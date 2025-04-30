package repositories

import (
	"A2SVHUB/internal/domain"
	"context"

	"errors"

	"log"

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

func (r *CountryRepository) GetAllCountries(ctx context.Context) ([]domain.CountryResponse, error) {
	var countries []domain.CountryResponse
	if err := r.db.WithContext(ctx).Find(&countries).Error; err != nil {
		return nil, err
	}
	return countries, nil
}

func (r *CountryRepository) GetCountryByID(ctx context.Context, id int) (domain.CountryDetailResponse, error) {
	var country domain.Country
	err := r.db.WithContext(ctx).First(&country, id).Error
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return domain.CountryDetailResponse{}, nil
		}
		log.Printf("Error fetching country by ID: %v", err) // Log the error
		return domain.CountryDetailResponse{}, err
	}

	// Get all users in this country
	var users []domain.User
	err = r.db.WithContext(ctx).Where("country_id = ?", id).Find(&users).Error
	if err != nil {
		log.Printf("Error fetching users for country ID %d: %v", id, err) // Log the error
		return domain.CountryDetailResponse{}, err
	}

	userResponses := make([]domain.UserStatResponse, 0)

	for _, user := range users {
		var totalProblemsSolved int64
		var rating domain.Rating

		// Get the latest rating for the user
		err := r.db.WithContext(ctx).
			Model(&domain.Rating{}).
			Where("user_id = ?", user.ID).
			Order("created_at DESC").
			First(&rating).Error
		if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
			log.Printf("Error fetching rating for user ID %d: %v", user.ID, err) // Log the error
			return domain.CountryDetailResponse{}, err
		}

		// Get total problems solved (distinct problems where IsSolved = true)
		err = r.db.WithContext(ctx).
			Model(&domain.Submission{}).
			Where("user_id = ? AND verified = ?", user.ID, true).
			Distinct("problem_id").
			Count(&totalProblemsSolved).Error
		if err != nil {
			log.Printf("Error fetching total problems solved for user ID %d: %v", user.ID, err) // Log the error
			return domain.CountryDetailResponse{}, err
		}

		// Get total time spent (sum of TimeSpent for the user)
		var totalTimeSpent int64
		err = r.db.WithContext(ctx).
			Model(&domain.Submission{}).
			Where("user_id = ?", user.ID).
			Select("COALESCE(SUM(time_spent), 0)"). // Use time_spent instead of penalty
			Scan(&totalTimeSpent).Error
		if err != nil {
			log.Printf("Error fetching total time spent for user ID %d: %v", user.ID, err) // Log the error
			return domain.CountryDetailResponse{}, err
		}

		userResponses = append(userResponses, domain.UserStatResponse{
			Name:                user.Name,
			Rating:              rating.Points,
			TotalTimeSpent:      int(totalTimeSpent),
			TotalProblemsSolved: int(totalProblemsSolved),
		})
	}

	countryDetail := domain.CountryDetailResponse{
		ID:        country.ID,
		Name:      country.Name,
		ShortCode: country.ShortCode,
		Users:     userResponses,
	}

	return countryDetail, nil
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
func (r *CountryRepository) IsCountryExists(ctx context.Context, name string, shortCode string) (bool, error) {
	var count int64
	if err := r.db.WithContext(ctx).
		Model(&domain.Country{}).
		Where("name = ? OR short_code = ?", name, shortCode).
		Count(&count).Error; err != nil {
		return false, err
	}
	return count > 0, nil
}

func (r *UserRepository) CountOfUsersByCountry(ctx context.Context, countryID int, role string) (int, error) {
	var count int64
	err := r.db.WithContext(ctx).Model(&domain.User{}).Where("country_id = ? AND role = ?", countryID, role).Count(&count).Error
	return int(count), err
}

func (r *CountryRepository) GetAllCountriesWithStats(ctx context.Context) ([]domain.CountryResponse, error) {
	var countries []domain.Country
	err := r.db.Find(&countries).Error
	if err != nil {
		return nil, err
	}

	var result []domain.CountryResponse

	for _, country := range countries {
		var users []domain.User
		err := r.db.Where("country_id = ?", country.ID).Find(&users).Error
		if err != nil {
			return nil, err
		}

		userIDs := make([]int, 0, len(users))
		totalRating := 0
		for _, user := range users {
			userIDs = append(userIDs, user.ID)
			// totalRating += user.Rating
		}
		totalUsers := len(userIDs)

		var totalTimeSpent int64
		if len(userIDs) > 0 {
			err := r.db.Model(&domain.Submission{}).
				Where("user_id IN ?", userIDs).
				Select("COALESCE(SUM(time_spent),0)").
				Scan(&totalTimeSpent).Error
			if err != nil {
				return nil, err
			}
		}

		var totalProblemsSolved int64
		if len(userIDs) > 0 {
			err := r.db.Model(&domain.Submission{}).
				Where("user_id IN ? AND verified = ?", userIDs, true).
				Distinct("problem_id").
				Count(&totalProblemsSolved).Error
			if err != nil {
				return nil, err
			}
		}

		avgRating := 0
		if totalUsers > 0 {
			avgRating = totalRating / totalUsers
		}

		countryWithStats := domain.CountryResponse{
			ID:                  country.ID,
			Name:                country.Name,
			ShortCode:           country.ShortCode,
			TotalUsers:          totalUsers,
			TotalTimeSpent:      int(totalTimeSpent),
			TotalProblemsSolved: int(totalProblemsSolved),
			AverageRating:       int(avgRating),
		}

		result = append(result, countryWithStats)
	}

	return result, nil
}
func (r *CountryRepository) CountUsersByCountryID(ctx context.Context, countryID int) (int64, error) {
	var count int64
	err := r.db.Model(&domain.User{}).
		Where("country_id = ?", countryID).
		Count(&count).Error
	return count, err
}
