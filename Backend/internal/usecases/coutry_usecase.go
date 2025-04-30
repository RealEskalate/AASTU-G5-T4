package usecases

import (
	"A2SVHUB/internal/domain"
	// "A2SVHUB/internal/repositories"
	"context"
	"fmt"
)

type CountryUseCase struct {
	CountryRepository domain.CountryRepository
}

func NewCountryUseCase(CountryRepository domain.CountryRepository) domain.CountryUseCase {
	return &CountryUseCase{
		CountryRepository: CountryRepository,
	}
}

func (c CountryUseCase) GetAllCountries(ctx context.Context) ([]domain.CountryResponse, error) {
	if ctx == nil {
		return nil, fmt.Errorf("context cannot be nil")
	}
	countryResponses, err := c.CountryRepository.GetAllCountriesWithStats(ctx)
	if err != nil {
		return nil, err
	}

	return countryResponses, nil
}

func (c CountryUseCase) GetCountryByID(ctx context.Context, id int) (domain.CountryDetailResponse, error) {
	if ctx == nil {
		return domain.CountryDetailResponse{}, fmt.Errorf("context cannot be nil")
	}
	countryDetailResponse, err := c.CountryRepository.GetCountryByID(ctx, id)
	if err != nil {
		return domain.CountryDetailResponse{}, err
	}

	return countryDetailResponse, nil
}

func (c CountryUseCase) CreateCountry(ctx context.Context, name string, shortCode string) (domain.Country, error) {
	if ctx == nil {
		return domain.Country{}, fmt.Errorf("context cannot be nil")
	}

	if name == "" {
		return domain.Country{}, fmt.Errorf("country name cannot be empty")
	}

	if shortCode == "" {
		return domain.Country{}, fmt.Errorf("country short code cannot be empty")
	}

	return c.CountryRepository.CreateCountry(ctx, name, shortCode)
}

func (c CountryUseCase) UpdateCountryByID(ctx context.Context, name string, shortCode string, ID int) (domain.Country, error) {
	if ctx == nil {
		return domain.Country{}, fmt.Errorf("context cannot be nil")
	}

	if name == "" {
		return domain.Country{}, fmt.Errorf("country name cannot be empty")
	}

	if shortCode == "" {
		return domain.Country{}, fmt.Errorf("country short code cannot be empty")
	}

	return c.CountryRepository.UpdateCountryByID(ctx, name, shortCode, ID)
}

func (c CountryUseCase) DeleteCountryByID(ctx context.Context, ID int) error {
	if ctx == nil {
		return fmt.Errorf("context cannot be nil")
	}
	return c.CountryRepository.DeleteCountryByID(ctx, ID)
}

func (uc *CountryUseCase) IsCountryExists(ctx context.Context, name string, shortCode string) (bool, error) {
	return uc.CountryRepository.IsCountryExists(ctx, name, shortCode)
}

func (c CountryUseCase) CheckCountryExists(ctx context.Context, name string, shortCode string) (bool, error) {
	if ctx == nil {
		return false, fmt.Errorf("context cannot be nil")
	}
	if name == "" {
		return false, fmt.Errorf("country name cannot be empty")
	}
	if shortCode == "" {
		return false, fmt.Errorf("country short code cannot be empty")
	}
	return c.CountryRepository.IsCountryExists(ctx, name, shortCode)
}

func (c CountryUseCase) GetAllCountriesWithStats(ctx context.Context) ([]domain.CountryResponse, error) {
	if ctx == nil {
		return nil, fmt.Errorf("context cannot be nil")
	}
	return c.CountryRepository.GetAllCountriesWithStats(ctx)
}

func (c *CountryUseCase) CountUsersByCountryID(ctx context.Context, countryID int) (int64, error) {
	if ctx == nil {
		return 0, fmt.Errorf("context cannot be nil")
	}

	return c.CountryRepository.CountUsersByCountryID(ctx, countryID)
}
