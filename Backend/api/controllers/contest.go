package controllers

import (
	"A2SVHUB/internal/domain"
	"net/http"
	"strconv"
	"strings"

	"github.com/gin-gonic/gin"
)

type ContestController struct {
	useCase     domain.ContestUseCase
	userUseCase domain.UserUseCase
}

func NewContestController(useCase domain.ContestUseCase, userUseCase domain.UserUseCase) *ContestController {
	return &ContestController{
		useCase:     useCase,
		userUseCase: userUseCase,
	}
}

func (cc *ContestController) GetAllContests(c *gin.Context) {
	contests, err := cc.useCase.GetAllContests(c.Request.Context())
	if err != nil {
		c.JSON(http.StatusInternalServerError, domain.ErrorResponse{Message: err.Error(), Status: 500})
		return
	}

	if len(contests) == 0 {
		c.JSON(http.StatusOK, domain.SuccessResponse{
			Message: "No contests found",
			Data:    []interface{}{},
			Status:  200,
		})
		return
	}

	// Get all users
	users, err := cc.userUseCase.GetAllUsers(c.Request.Context())
	if err != nil {
		c.JSON(http.StatusInternalServerError, domain.ErrorResponse{Message: "Failed to fetch users", Status: 500})
		return
	}

	extractHandle := func(codeforcesURL string) string {
		if codeforcesURL == "" {
			return ""
		}
		parts := strings.Split(codeforcesURL, "/")
		if len(parts) > 0 {
			return parts[len(parts)-1]
		}
		return ""
	}

	type Member struct {
		Handle string `json:"handle"`
		ID     int    `json:"-"`
	}

	type Row struct {
		Party struct {
			Members []Member `json:"members"`
		} `json:"party"`
		Rank    int `json:"rank"`
		Penalty int `json:"penalty"`
		Rating  int `json:"rating"`
	}

	type ContestResponse struct {
		Status string `json:"status"`
		Result struct {
			Contest struct {
				ID   int    `json:"id"`
				Name string `json:"name"`
				Type string `json:"type"`
			} `json:"contest"`
			Rows []Row `json:"rows"`
		} `json:"result"`
	}

	var formattedContests []ContestResponse
	for _, contest := range contests {
		var contestResp ContestResponse
		contestResp.Status = "OK"
		contestResp.Result.Contest.ID = contest.ID
		contestResp.Result.Contest.Name = contest.Name
		contestResp.Result.Contest.Type = contest.Type

		// Map to track seen handles and their best rating
		seenHandles := make(map[string]Row)

		// Process existing ratings
		for _, rating := range contest.Ratings {
			if rating.User.Codeforces == "" {
				continue
			}

			handle := extractHandle(rating.User.Codeforces)
			if handle == "" {
				continue
			}

			row := Row{
				Party: struct {
					Members []Member `json:"members"`
				}{
					Members: []Member{
						{
							Handle: handle,
							ID:     rating.UserID,
						},
					},
				},
				Rank:    rating.Rank,
				Penalty: rating.Penalty,
				Rating:  rating.Points,
			}

			// Keep the row with the best rank for each handle
			if existingRow, exists := seenHandles[handle]; !exists || row.Rank < existingRow.Rank {
				seenHandles[handle] = row
			}
		}

		// Add missing users with default values
		for _, user := range users {
			handle := extractHandle(user.Codeforces)
			if handle == "" {
				continue
			}

			if _, exists := seenHandles[handle]; !exists {
				row := Row{
					Party: struct {
						Members []Member `json:"members"`
					}{
						Members: []Member{
							{
								Handle: handle,
								ID:     user.ID,
							},
						},
					},
					Rank:    0,
					Penalty: 0,
					Rating:  0,
				}
				seenHandles[handle] = row
			}
		}

		// Convert map to slice
		for _, row := range seenHandles {
			contestResp.Result.Rows = append(contestResp.Result.Rows, row)
		}

		formattedContests = append(formattedContests, contestResp)
	}

	c.JSON(http.StatusOK, domain.SuccessResponse{
		Message: "Contests retrieved successfully",
		Data:    formattedContests,
		Status:  200,
	})
}

func (cc *ContestController) GetContestByID(c *gin.Context) {
	id, err := strconv.Atoi(c.Param("id"))
	if err != nil {
		c.JSON(http.StatusBadRequest, domain.ErrorResponse{Message: "Invalid ID", Status: 400})
		return
	}
	contest, err := cc.useCase.GetContestByID(c.Request.Context(), id)
	if err != nil {
		c.JSON(http.StatusNotFound, domain.ErrorResponse{Message: "Contest not found", Status: 404})
		return
	}
	c.JSON(http.StatusOK, domain.SuccessResponse{Message: "Contest retrieved successfully", Data: contest, Status: 200})
}

func (cc *ContestController) AddContest(ctx *gin.Context) {
	type AddContestRequest struct {
		Name string `json:"name" binding:"required"`
		Link string `json:"link" binding:"required"`
	}

	var req AddContestRequest
	if err := ctx.ShouldBindJSON(&req); err != nil {
		ctx.JSON(http.StatusBadRequest, map[string]string{"error": "Invalid request body"})
		return
	}

	contest := &domain.Contest{
		Name:   req.Name,
		Link:   req.Link,
		Rating: 1,
	}

	if err := cc.useCase.AddContest(ctx.Request.Context(), contest); err != nil {
		ctx.JSON(http.StatusInternalServerError, map[string]string{"error": err.Error()})
		return
	}
	ctx.JSON(http.StatusCreated, map[string]int{"contest_id": contest.ID})
}

func (cc *ContestController) GetStandings(c *gin.Context) {
	contestID, err := strconv.Atoi(c.Param("id"))
	if err != nil {
		c.JSON(http.StatusBadRequest, domain.ErrorResponse{Message: "Invalid contest ID", Status: 400})
		return
	}

	standings, err := cc.useCase.GetStandings(c.Request.Context(), contestID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, domain.ErrorResponse{Message: err.Error(), Status: 500})
		return
	}

	c.JSON(http.StatusOK, domain.SuccessResponse{
		Message: "Standings retrieved successfully",
		Data:    standings,
		Status:  200,
	})
}

func (cc *ContestController) SaveStandings(c *gin.Context) {
	contestID, err := strconv.Atoi(c.Param("id"))
	if err != nil {
		c.JSON(http.StatusBadRequest, domain.ErrorResponse{Message: "Invalid contest ID", Status: 400})
		return
	}

	var standings domain.StandingsResponse
	if err := c.ShouldBindJSON(&standings); err != nil {
		c.JSON(http.StatusBadRequest, domain.ErrorResponse{Message: "Invalid standings data", Status: 400})
		return
	}

	if err := cc.useCase.SaveStandings(c.Request.Context(), contestID, &standings); err != nil {
		c.JSON(http.StatusInternalServerError, domain.ErrorResponse{Message: err.Error(), Status: 500})
		return
	}

	c.JSON(http.StatusOK, domain.SuccessResponse{
		Message: "Standings saved successfully",
		Data:    standings,
		Status:  200,
	})
}

func (cc *ContestController) RefreshStandings(c *gin.Context) {
	contestID, err := strconv.Atoi(c.Param("id"))
	if err != nil {
		c.JSON(http.StatusBadRequest, domain.ErrorResponse{Message: "Invalid contest ID", Status: 400})
		return
	}

	if err := cc.useCase.ClearStandingsCache(c.Request.Context(), contestID); err != nil {
		c.JSON(http.StatusInternalServerError, domain.ErrorResponse{Message: err.Error(), Status: 500})
		return
	}

	standings, err := cc.useCase.GetStandings(c.Request.Context(), contestID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, domain.ErrorResponse{Message: err.Error(), Status: 500})
		return
	}

	c.JSON(http.StatusOK, domain.SuccessResponse{
		Message: "Standings refreshed successfully",
		Data:    standings,
		Status:  200,
	})
}
