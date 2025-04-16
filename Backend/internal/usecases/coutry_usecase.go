package usecases

import (
	"A2SVHUB/internal/domain"
	"context"
)

type CountryUseCase struct {
	CountryRepository domain.CountryRepository
}

func NewCountryUseCase(CountryRepository domain.CountryRepository) domain.CountryUseCase {
	return CountryUseCase{
		CountryRepository: CountryRepository,
	}
}

func (c CountryUseCase) GetAllCountries(ctx context.Context) ([]domain.Country, error) {
	return c.CountryRepository.GetAllCountries(ctx)
}

func (c CountryUseCase) GetCountryByID(ctx context.Context, id int) (domain.Country, error) {
	return c.CountryRepository.GetCountryByID(ctx, id)
}

func (c CountryUseCase) CreateCountry(ctx context.Context, name string, shortCode string) (domain.Country, error) {
	return c.CountryRepository.CreateCountry(ctx, name, shortCode)
}

func (c CountryUseCase) UpdateCountryByID(ctx context.Context, name string, shortCode string, ID int) (domain.Country, error) {
	return c.CountryRepository.UpdateCountryByID(ctx, name, shortCode, ID)
}

func (c CountryUseCase) DeleteCountryByID(ctx context.Context, ID int) error {
	return c.CountryRepository.DeleteCountryByID(ctx, ID)
}
