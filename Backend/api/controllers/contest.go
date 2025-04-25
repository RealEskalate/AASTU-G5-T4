package controllers

import (
	"A2SVHUB/internal/domain"
	"net/http"
	"strconv"
	"strings"

	"github.com/gin-gonic/gin"
)

type ContestController struct {
	useCase domain.ContestUseCase
}

func NewContestController(useCase domain.ContestUseCase) *ContestController {
	return &ContestController{useCase: useCase}
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

	type ProblemResult struct {
		Points                    float64 `json:"points"`
		RejectedAttemptCount      int     `json:"rejectedAttemptCount"`
		Type                      string  `json:"type"`
		BestSubmissionTimeSeconds int     `json:"bestSubmissionTimeSeconds"`
	}

	type Member struct {
		Handle string `json:"handle"`
		ID     int    `json:"-"`
	}

	type ContestResponse struct {
		Status string `json:"status"`
		Result struct {
			Contest struct {
				ID   int    `json:"id"`
				Name string `json:"name"`
				Type string `json:"type"`
			} `json:"contest"`
			Problems []struct {
				Index string   `json:"index"`
				Name  string   `json:"name"`
				Tags  []string `json:"tags"`
			} `json:"problems"`
			Rows []struct {
				Party struct {
					Members []Member `json:"members"`
				} `json:"party"`
				Rank           int             `json:"rank"`
				Points         float64         `json:"points"`
				Penalty        int             `json:"penalty"`
				ProblemResults []ProblemResult `json:"problemResults"`
			} `json:"rows"`
		} `json:"result"`
	}

	var formattedContests []ContestResponse
	for _, contest := range contests {
		var contestResp ContestResponse
		contestResp.Status = "OK"
		contestResp.Result.Contest.ID = contest.ID
		contestResp.Result.Contest.Name = contest.Name
		contestResp.Result.Contest.Type = contest.Type

		contestResp.Result.Problems = []struct {
			Index string   `json:"index"`
			Name  string   `json:"name"`
			Tags  []string `json:"tags"`
		}{
			{Index: "A", Name: "Problem A", Tags: []string{}},
			{Index: "B", Name: "Problem B", Tags: []string{}},
			{Index: "C", Name: "Problem C", Tags: []string{}},
		}

		for _, rating := range contest.Ratings {
			if rating.User.Codeforces == "" {
				continue
			}

			handle := extractHandle(rating.User.Codeforces)
			if handle == "" {
				continue
			}

			problemResults := make([]ProblemResult, len(contestResp.Result.Problems))
			for i := range problemResults {
				problemResults[i] = ProblemResult{
					Points:                    0,
					RejectedAttemptCount:      0,
					Type:                      "FINAL",
					BestSubmissionTimeSeconds: 0,
				}
			}

			if rating.Rank == 1 {
				problemResults[0].Points = 1
				problemResults[0].BestSubmissionTimeSeconds = 2147483647
			}

			row := struct {
				Party struct {
					Members []Member `json:"members"`
				} `json:"party"`
				Rank           int             `json:"rank"`
				Points         float64         `json:"points"`
				Penalty        int             `json:"penalty"`
				ProblemResults []ProblemResult `json:"problemResults"`
			}{
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
				Rank:           rating.Rank,
				Points:         float64(rating.Points),
				Penalty:        rating.Penalty,
				ProblemResults: problemResults,
			}
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

	contestID, err := cc.useCase.AddContest(ctx.Request.Context(), req.Name, req.Link)

	if err != nil {
		ctx.JSON(http.StatusInternalServerError, map[string]string{"error": err.Error()})
		return
	}
	ctx.JSON(http.StatusCreated, map[string]int{"contest_id": contestID})
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
