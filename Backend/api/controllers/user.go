package controllers

import (
	"A2SVHUB/internal/domain"
	"A2SVHUB/utils"
	"context"
	"encoding/json"
	"fmt"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
)

type UserController struct {
	UserUseCase       domain.UserUseCase
	SubmissionUseCase domain.SubmissionUseCase
}

func NewUserController(useCase domain.UserUseCase, submissionUseCase domain.SubmissionUseCase) *UserController {
	return &UserController{
		UserUseCase:       useCase,
		SubmissionUseCase: submissionUseCase,
	}
}

func (uc *UserController) GetAllUsers(c *gin.Context) {
	users, err := uc.UserUseCase.GetAllUsers(c.Request.Context())
	if err != nil {
		c.JSON(http.StatusInternalServerError, domain.ErrorResponse{
			Message: err.Error(), Status: 500,
		})
		return
	}
	c.JSON(http.StatusOK, domain.SuccessResponse{
		Message: "Users retrieved successfully",
		Data:    domain.ToUserResponseList(users),
		Status:  200,
	})
}

func (uc *UserController) GetUserByID(c *gin.Context) {
	id, err := strconv.Atoi(c.Param("id"))
	if err != nil {
		c.JSON(http.StatusBadRequest, domain.ErrorResponse{
			Message: "Invalid user ID", Status: 400,
		})
		return
	}
	user, err := uc.UserUseCase.GetUserByID(c.Request.Context(), id)
	if err != nil {
		c.JSON(http.StatusNotFound, domain.ErrorResponse{
			Message: err.Error(), Status: 404,
		})
		return
	}
	c.JSON(http.StatusOK, domain.SuccessResponse{
		Message: "User retrieved successfully",
		Data:    domain.ToUserResponse(user),
		Status:  200,
	})
}

func (uc UserController) CreateUser(c *gin.Context) {

	data := c.PostForm("data")
	if data == "" {
		c.JSON(400, gin.H{"detail": "Missing 'data' field in form-data"})
		return
	}

	var user domain.User
	if err := json.Unmarshal([]byte(data), &user); err != nil {
		c.JSON(400, gin.H{"detail": "Invalid JSON in 'data' field", "error": err.Error()})
		return
	}

	file, err := c.FormFile("AvatarURL")
	if err == nil {
		imageURL, err := utils.UploadToCloudinary(file)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to upload image"})
			return
		}
		user.AvatarURL = imageURL
	} else if err != http.ErrMissingFile {
		c.JSON(500, gin.H{"error": "Failed to receive image", "details": err.Error()})
		return
	}

	createdUser, err := uc.UserUseCase.CreateUser(context.TODO(), user)
	if err != nil {
		c.JSON(500, gin.H{"detail": "Failed to create user"})
		return
	}

	c.JSON(201, gin.H{"user": createdUser})
}

func (uc UserController) UpdateUser(c *gin.Context) {
	idStr := c.Param("id")
	id, err := strconv.Atoi(idStr)
	if err != nil {
		c.JSON(400, gin.H{"detail": "Invalid ID format"})
		return
	}

	data := c.PostForm("data")
	if data == "" {
		c.JSON(400, gin.H{"detail": "Missing 'data' field in form-data"})
		return
	}

	var user domain.User
	if err := json.Unmarshal([]byte(data), &user); err != nil {
		c.JSON(400, gin.H{"detail": "Invalid JSON in 'data' field", "error": err.Error()})
		return
	}

	user.ID = id

	file, err := c.FormFile("AvatarURL")
	if err == nil {
		imageURL, err := utils.UploadToCloudinary(file)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to upload image"})
			return
		}
		user.AvatarURL = imageURL
	}

	updatedUser, err := uc.UserUseCase.UpdateUser(context.TODO(), id, user)
	if err != nil {
		c.JSON(500, gin.H{"detail": fmt.Sprintf("Failed to update user: %v", err)})
		return
	}

	c.JSON(200, gin.H{"user": updatedUser})
}

func (uc UserController) DeleteUser(c *gin.Context) {
	idStr := c.Param("id")
	id, err := strconv.Atoi(idStr)
	if err != nil {
		c.JSON(400, gin.H{"detail": "Invalid ID format"})
		return
	}
	if err := uc.UserUseCase.DeleteUser(context.TODO(), id); err != nil {
		c.JSON(500, gin.H{"detail": fmt.Sprintf("Failed to delete user: %v", err)})
		return
	}
	c.JSON(204, nil)
}

func (uc UserController) CreateUsers(c *gin.Context) {
	var users []domain.User
	if err := c.ShouldBindJSON(&users); err != nil {
		c.JSON(400, gin.H{"detail": "Invalid request body"})
		return
	}
	createdUsers, err := uc.UserUseCase.CreateUsers(context.TODO(), users)
	if err != nil {
		c.JSON(500, gin.H{"detail": "Failed to create users"})
		return
	}
	c.JSON(201, gin.H{"users": createdUsers})
}

func (uc *UserController) GetUsersByGroup(c *gin.Context) {
	groupID, err := strconv.Atoi(c.Param("group_id"))
	if err != nil {
		c.JSON(http.StatusBadRequest, domain.ErrorResponse{
			Message: "Invalid group ID", Status: 400,
		})
		return
	}

	users, err := uc.UserUseCase.GetUsersByGroup(c.Request.Context(), groupID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, domain.ErrorResponse{
			Message: "Failed to fetch users", Status: 500,
		})
		return
	}

	var userResponses []domain.UserResponse
	for _, user := range users {
		userResponses = append(userResponses, domain.ToUserResponse(user))
	}

	c.JSON(http.StatusOK, domain.SuccessResponse{
		Message: "Users retrieved successfully",
		Data:    userResponses,
		Status:  200,
	})
}

func (uc UserController) UploadUserImage(c *gin.Context) {
	userID := c.Param("id")

	file, err := c.FormFile("avatar")
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "No image uploaded"})
		return
	}

	imageURL, err := utils.UploadToCloudinary(file)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to upload image"})
		return
	}

	userIDInt, err := strconv.Atoi(userID)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid user ID format"})
		return
	}

	updateErr := uc.UserUseCase.UpdateAvatar(context.TODO(), userIDInt, imageURL)
	if updateErr != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to update user avatar"})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"message":   "Image uploaded and user avatar updated successfully",
		"image_url": imageURL,
	})
}

func (uc *UserController) GetUserSubmissions(c *gin.Context) {
	userID, err := strconv.Atoi(c.Param("id"))
	if err != nil {
		c.JSON(http.StatusBadRequest, domain.ErrorResponse{Message: "Invalid user ID", Status: 400})
		return
	}

	submissions, totalSolved, totalTimeSpent, err := uc.UserUseCase.GetUserSubmissions(c.Request.Context(), userID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, domain.ErrorResponse{Message: err.Error(), Status: 500})
		return
	}

	type SubmissionStats struct {
		Submissions    []domain.Submission `json:"submissions"`
		TotalSolved    float64             `json:"total_solved"`
		TotalTimeSpent int64               `json:"total_time_spent"`
	}

	c.JSON(http.StatusOK, domain.SuccessResponse{
		Message: "User submissions retrieved successfully",
		Data: SubmissionStats{
			Submissions:    submissions,
			TotalSolved:    totalSolved,
			TotalTimeSpent: totalTimeSpent,
		},
		Status: 200,
	})
}
