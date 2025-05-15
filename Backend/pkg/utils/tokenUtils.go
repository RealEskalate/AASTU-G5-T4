package utils

import (
	"A2SVHUB/pkg/config"
	"fmt"
	"time"

	"github.com/golang-jwt/jwt/v5"
)

type TokenService struct {
	config config.Config
}

func NewTokenService(config config.Config) *TokenService {
	return &TokenService{
		config: config,
	}
}

func (t *TokenService) GenerateAccessToken(userID int, roleID int) (string, error) {
	claims := jwt.MapClaims{

		"sub":     userID,
		"role_id": roleID,
		"iat":     time.Now().Unix(),
		"exp":     time.Now().Add(time.Hour * 24 * 10).Unix(),
	}
	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
	tokenString, err := token.SignedString([]byte(t.config.JWTSecret))
	if err != nil {
		return "", err
	}
	return tokenString, nil
}

func (t *TokenService) GenerateRefreshToken(userID int) (string, error) {
	claims := jwt.MapClaims{
		"sub": userID,
		"iat": time.Now().Unix(),
		"exp": time.Now().Add(time.Hour * 24 * 7).Unix(), // 7 days expiry
	}
	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
	tokenString, err := token.SignedString([]byte(t.config.JWTSecret))
	if err != nil {
		return "", err
	}
	return tokenString, nil
}

func (t *TokenService) VerifyJWT(tokenString string) (int, error) {
	token, err := jwt.Parse(tokenString, func(token *jwt.Token) (interface{}, error) {
		if _, ok := token.Method.(*jwt.SigningMethodHMAC); !ok {
			return nil, fmt.Errorf("unexpected signing method: %v", token.Header["alg"])
		}
		return []byte(t.config.JWTSecret), nil
	})

	if err != nil {
		return 0, fmt.Errorf("failed to parse token: %v", err)
	}

	if !token.Valid {
		return 0, fmt.Errorf("invalid token")
	}

	claims, ok := token.Claims.(jwt.MapClaims)
	if !ok {
		return 0, fmt.Errorf("invalid claims format")
	}

	userID, ok := claims["sub"].(float64)
	if !ok {
		return 0, fmt.Errorf("missing or invalid userId in token")
	}

	return int(userID), nil
}

func (ts *TokenService) GenerateInviteAccessToken(userID int, roleID int) (string, error) {
	claims := jwt.MapClaims{
		"user_id": userID,
		"role_id": roleID,
		"exp":     time.Now().Add(time.Hour * 24).Unix(),
	}

	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
	return token.SignedString([]byte(ts.config.JWTSecret))
}

func (t *TokenService) VerifyTokenRaw(tokenString string) (*jwt.Token, error) {
	return jwt.Parse(tokenString, func(token *jwt.Token) (interface{}, error) {
		if _, ok := token.Method.(*jwt.SigningMethodHMAC); !ok {
			return nil, fmt.Errorf("unexpected signing method: %v", token.Header["alg"])
		}
		return []byte(t.config.JWTSecret), nil
	})
}
