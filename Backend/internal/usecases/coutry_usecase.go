package usecases

import (
	"A2SVHUB/internal/domain"
	"context"
)

type CountryUseCase struct {
	CountryRepository domain.CountryRepository
}

func NewCountryUseCase(countryRepository domain.CountryRepository) CountryUseCase {
	return CountryUseCase{
		CountryRepository: countryRepository,
	}
}

func (c *CountryUseCase) GetAllCountries(ctx context.Context) ([]domain.Country, error) {
	return c.CountryRepository.GetAllCountries(ctx)
}

// func (c *CountryUseCase) GetCountryByID(ctx context.Context, id int) (domain.Country, error) {
// 	return c.CountryRepository.GetCountryByID(ctx, id)
// }
