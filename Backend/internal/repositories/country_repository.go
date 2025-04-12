package repositories

import (
	"A2SVHUB/internal/domain"
	"context"

	"gorm.io/gorm"
)

type CountryRepository struct {
	db *gorm.DB
}

func NewCountryRepository(db *gorm.DB) *CountryRepository {
	return &CountryRepository{db: db}
}

func (r *CountryRepository) GetAllCountries(ctx context.Context) ([]domain.Country, error) {
	var countries []domain.Country
	if err := r.db.WithContext(ctx).Find(&countries).Error; err != nil {
		return nil, err
	}
	return countries, nil
}

func (r *CountryRepository) GetCountryByID(ctx context.Context, id int) (domain.Country, error) {
	var country domain.Country
	if err := r.db.WithContext(ctx).First(&country, id).Error; err != nil {
		return domain.Country{}, err
	}
	return country, nil
}
