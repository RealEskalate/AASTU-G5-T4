package repositories

import (
	"A2SVHUB/internal/domain"
	"context"
)

type StipendRepository interface {
	Create(ctx context.Context, stipend *domain.Stipend) error
	GetByID(ctx context.Context, id int) (*domain.Stipend, error)
	GetByUserID(ctx context.Context, userID int) ([]*domain.Stipend, error)
	GetBySessionID(ctx context.Context, sessionID int) ([]*domain.Stipend, error)
	Update(ctx context.Context, stipend *domain.Stipend) error
	Delete(ctx context.Context, id int) error
}
