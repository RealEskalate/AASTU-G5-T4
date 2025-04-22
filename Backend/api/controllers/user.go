package controllers

import (
	"A2SVHUB/internal/domain"
	"A2SVHUB/utils"
	"context"
	"fmt"
	"net/http"
	"strconv"
	"strings"
	"time"

	"github.com/gin-gonic/gin"
)

type UserController struct {
	UserUseCase domain.UserUseCase
}

func NewUserController(uuc domain.UserUseCase) *UserController {
	return &UserController{
		UserUseCase: uuc,
	}
}

func (uc UserController) GetAllUsers(c *gin.Context) {
	users, err := uc.UserUseCase.GetAllUsers(context.TODO())
	if err != nil {
		c.JSON(500, gin.H{"detail": "Something went wrong"})
		return
	}
	c.JSON(200, gin.H{"users": users})
}

func (uc UserController) GetUserByID(c *gin.Context) {
	idStr := c.Param("id")
	id, err := strconv.Atoi(idStr)
	if err != nil {
		c.JSON(400, gin.H{"detail": "Invalid ID format"})
		return
	}
	user, err := uc.UserUseCase.GetUserByID(context.TODO(), id)
	if err != nil {
		c.JSON(404, gin.H{"detail": "User not found"})
		return
	}
	c.JSON(200, gin.H{"user": user})
}

func (uc UserController) CreateUser(c *gin.Context) {
	var user domain.User

	if err := c.ShouldBind(&user); err != nil {

		c.JSON(400, gin.H{"detail": "Invalid form data", "error": err.Error()})
		return
	}

	file, err := c.FormFile("avatar")
	if err == nil {
		if !strings.HasSuffix(file.Filename, ".jpg") && !strings.HasSuffix(file.Filename, ".jpeg") && !strings.HasSuffix(file.Filename, ".png") {
			c.JSON(400, gin.H{"detail": "Invalid avatar format. Only JPG, JPEG, or PNG allowed."})
			return
		}

		path := fmt.Sprintf("uploads/avatars/%d_%s", time.Now().Unix(), file.Filename)
		if err := c.SaveUploadedFile(file, path); err != nil {
			c.JSON(500, gin.H{"detail": "Failed to upload avatar"})
			return
		}
		user.AvatarURL = "/" + path
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

	var user domain.User
	if err := c.ShouldBind(&user); err != nil {
		c.JSON(400, gin.H{"detail": "Invalid form data", "error": err.Error()})
		return
	}

	file, err := c.FormFile("avatar")
	if err == nil {
		if !strings.HasSuffix(file.Filename, ".jpg") && !strings.HasSuffix(file.Filename, ".jpeg") && !strings.HasSuffix(file.Filename, ".png") {
			c.JSON(400, gin.H{"detail": "Invalid avatar format. Only JPG, JPEG, or PNG allowed."})
			return
		}

		path := fmt.Sprintf("uploads/avatars/%d_%s", time.Now().Unix(), file.Filename)
		if err := c.SaveUploadedFile(file, path); err != nil {
			c.JSON(500, gin.H{"detail": "Failed to upload avatar"})
			return
		}
		user.AvatarURL = "/" + path
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
	groupIDStr := c.Param("group_id")

	groupID, err := strconv.Atoi(groupIDStr)
	if err != nil {
		c.JSON(400, gin.H{"detail": "Invalid group_id format"})
		return
	}

	users, err := uc.UserUseCase.GetUsersByGroup(context.TODO(), groupID)
	if err != nil {
		c.JSON(500, gin.H{"detail": "Failed to fetch users"})
		return
	}
	c.JSON(200, gin.H{"users": users})
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
