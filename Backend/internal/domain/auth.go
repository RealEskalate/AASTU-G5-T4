package domain

import "A2SVHUB/internal/dtos"

type AuthUseCase interface {
	Login(request dtos.LoginRequest) (*dtos.LoginResponse, *ErrorResponse)
}
