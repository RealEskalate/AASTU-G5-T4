package usecases

import (
	"A2SVHUB/internal/domain"
	"A2SVHUB/internal/dtos"
	"A2SVHUB/pkg/config"
	"A2SVHUB/pkg/utils"
	"context"
)

type AuthUseCase struct {
	userRepo     domain.UserRepository
	config       config.Config
	tokenService *utils.TokenService
}

func NewAuthUseCase(userRepo domain.UserRepository, config config.Config, tokenService *utils.TokenService) *AuthUseCase {
	return &AuthUseCase{
		userRepo:     userRepo,
		config:       config,
		tokenService: tokenService,
	}
}

func (a *AuthUseCase) Login(request dtos.LoginRequest) (*dtos.LoginResponse, *domain.ErrorResponse) {
	user, err := a.userRepo.GetUserByEmail(context.TODO(), request.Email)
	if err != nil {
		return nil, &domain.ErrorResponse{
			Message: "Invalid email or password",
			Status:  401,
		}
	}

	if user.Password != request.Password {
		return nil, &domain.ErrorResponse{
			Message: "Invalid email or password",
			Status:  401,
		}
	}

	accessToken, err := a.tokenService.GenerateAccessToken(user.ID, user.RoleID)
	if err != nil {
		return nil, &domain.ErrorResponse{
			Message: "Failed to generate access token",
			Status:  500,
		}
	}

	refreshToken, err := a.tokenService.GenerateRefreshToken(user.ID)
	if err != nil {
		return nil, &domain.ErrorResponse{
			Message: "Failed to generate refresh token",
			Status:  500,
		}
	}

	userResponse := dtos.LoginUserResponse{
		ID:                user.ID,
		RoleID:            user.RoleID,
		Name:              user.Name,
		CountryID:         user.CountryID,
		University:        user.University,
		Email:             user.Email,
		Leetcode:          user.Leetcode,
		Codeforces:        user.Codeforces,
		Github:            user.Github,
		AvatarURL:         user.AvatarURL,
		PreferredLanguage: user.PreferredLanguage,
		Hackerrank:        user.Hackerrank,
		GroupID:           user.GroupID,
		Phone:             user.Phone,
		TelegramUsername:  user.TelegramUsername,
		TelegramUID:       user.TelegramUID,
		Linkedin:          user.Linkedin,
		StudentID:         user.StudentID,
		ShortBio:          user.ShortBio,
		Instagram:         user.Instagram,
		Birthday:          user.Birthday.Format("2006-01-02"),
		Gender:            user.Gender,
		Department:        user.Department,
		Role:              user.Role.Type,
		Country:           user.Country.Name,
	}

	return &dtos.LoginResponse{
		Token:        accessToken,
		RefreshToken: refreshToken,
		User:         userResponse,
	}, nil
}
