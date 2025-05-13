package repositories

import (
	"A2SVHUB/internal/domain"
	"context"

	"gorm.io/gorm"
)

type stipendRepository struct {
	db *gorm.DB
}

func NewStipendRepository(db *gorm.DB) StipendRepository {
	return &stipendRepository{db: db}
}

func (r *stipendRepository) Create(ctx context.Context, stipend *domain.Stipend) error {
	return r.db.WithContext(ctx).Create(stipend).Error
}

func (r *stipendRepository) GetByID(ctx context.Context, id int) (*domain.Stipend, error) {
	var stipend domain.Stipend
	err := r.db.WithContext(ctx).First(&stipend, id).Error
	if err != nil {
		return nil, err
	}
	return &stipend, nil
}

func (r *stipendRepository) GetByUserID(ctx context.Context, userID int) ([]*domain.Stipend, error) {
	var stipends []*domain.Stipend
	err := r.db.WithContext(ctx).Where("user_id = ?", userID).Find(&stipends).Error
	if err != nil {
		return nil, err
	}
	return stipends, nil
}

func (r *stipendRepository) GetBySessionID(ctx context.Context, sessionID int) ([]*domain.Stipend, error) {
	var stipends []*domain.Stipend
	err := r.db.WithContext(ctx).Where("session_id = ?", sessionID).Find(&stipends).Error
	if err != nil {
		return nil, err
	}
	return stipends, nil
}

func (r *stipendRepository) Update(ctx context.Context, stipend *domain.Stipend) error {
	return r.db.WithContext(ctx).Save(stipend).Error
}

func (r *stipendRepository) Delete(ctx context.Context, id int) error {
	return r.db.WithContext(ctx).Delete(&domain.Stipend{}, id).Error
}
