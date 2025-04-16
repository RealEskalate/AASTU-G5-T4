package repositories

import (
	"A2SVHUB/internal/domain"
	"context"

	"gorm.io/gorm"
)

type CountryRepository struct {
	db gorm.DB
}

func NewCountryRepository(db gorm.DB) domain.CountryRepository {
	return &CountryRepository{
		db: db,
	}
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

func (r *CountryRepository) CreateCountry(ctx context.Context, name string, shortCode string) (domain.Country, error) {
	country := domain.Country{
		Name:      name,
		ShortCode: shortCode,
	}
	if err := r.db.WithContext(ctx).Create(&country).Error; err != nil {
		return domain.Country{}, err
	}
	return country, nil
}

func (r *CountryRepository) UpdateCountryByID(ctx context.Context, name string, shortCode string, ID int) (domain.Country, error) {
	var country domain.Country
	if err := r.db.WithContext(ctx).First(&country, ID).Error; err != nil {
		return domain.Country{}, err
	}
	country.Name = name
	country.ShortCode = shortCode
	if err := r.db.WithContext(ctx).Save(&country).Error; err != nil {
		return domain.Country{}, err
	}
	return country, nil
}

func (r *CountryRepository) DeleteCountryByID(ctx context.Context, ID int) error {
	var country domain.Country
	if err := r.db.WithContext(ctx).First(&country, ID).Error; err != nil {
		return err
	}
	if err := r.db.WithContext(ctx).Delete(&country).Error; err != nil {
		return err
	}
	return nil
}
