package domain

// models/common.go

import (
	"context"
	"time"
)

type Country struct {
	ID        int       `gorm:"primaryKey"`
	Name      string    `gorm:"type:varchar(255)"`
	ShortCode string    `gorm:"type:varchar(255)"`
	CreatedAt time.Time `gorm:"type:timestamp"`
	UpdatedAt time.Time `gorm:"type:timestamp"`
}

type CountryResponse struct {
	ID                  int    `json:"id"`
	Name                string `json:"name"`
	ShortCode           string `json:"short_code"`
	TotalUsers          int    `json:"total_students"`
	TotalTimeSpent      int    `json:"total_time_spent"`
	TotalProblemsSolved int    `json:"total_problems_solved"`
	AverageRating       int    `json:"average_rating"`
}

type UserStatResponse struct {
	Name                string `json:"name"`
	Rating              int    `json:"rating"`
	TotalTimeSpent      int    `json:"total_time_spent"`
	TotalProblemsSolved int    `json:"total_problems_solved"`
}

type CountryDetailResponse struct {
	ID        int                `json:"id"`
	Name      string             `json:"name"`
	ShortCode string             `json:"short_code"`
	Users     []UserStatResponse `json:"users"`
}

type Division struct {
	ID          int       `gorm:"primaryKey"`
	Name        string    `gorm:"type:varchar(255)"`
	Description string    `gorm:"type:varchar(255)"`
	CreatedAt   time.Time `gorm:"type:timestamp"`
	UpdatedAt   time.Time `gorm:"type:timestamp"`
}

type File struct {
	ID        int       `gorm:"primaryKey"`
	URL       string    `gorm:"type:varchar(255)"`
	Name      string    `gorm:"type:varchar(255)"`
	Fid       string    `gorm:"type:varchar(255)"`
	CreatedAt time.Time `gorm:"type:timestamp"`
	UpdatedAt time.Time `gorm:"type:timestamp"`
}

type Fund struct {
	ID          int       `gorm:"primaryKey"`
	Name        string    `gorm:"type:varchar(255)"`
	Description string    `gorm:"type:text"`
	Amount      float32   `gorm:"type:real"`
	Currency    string    `gorm:"type:varchar(255)"`
	CreatedAt   time.Time `gorm:"type:timestamp"`
	UpdatedAt   time.Time `gorm:"type:timestamp"`
}

type Event struct {
	ID        int       `gorm:"primaryKey"`
	Type      string    `gorm:"type:varchar(255)"`
	StartTime time.Time `gorm:"type:timestamp"`
	EndTime   time.Time `gorm:"type:timestamp"`
	Recurring int       `gorm:"type:integer"`
	Link      string    `gorm:"type:varchar(255)"`
	CreatedAt time.Time `gorm:"type:timestamp"`
	UpdatedAt time.Time `gorm:"type:timestamp"`
}

type CountryRepository interface {
	GetAllCountries(ctx context.Context) ([]CountryResponse, error)
	GetCountryByID(ctx context.Context, id int) (CountryDetailResponse, error)
	CreateCountry(ctx context.Context, name string, shortCode string) (Country, error)
	UpdateCountryByID(ctx context.Context, name string, shortCode string, ID int) (Country, error)
	DeleteCountryByID(ctx context.Context, ID int) error
	IsCountryExists(ctx context.Context, name string, shortCode string) (bool, error)
	GetAllCountriesWithStats(ctx context.Context) ([]CountryResponse, error)
	CountUsersByCountryID(ctx context.Context, countryID int) (int64, error)
}
type CountryUseCase interface {
	GetAllCountries(ctx context.Context) ([]CountryResponse, error)
	GetCountryByID(ctx context.Context, id int) (CountryDetailResponse, error)
	CreateCountry(ctx context.Context, name string, shortCode string) (Country, error)
	UpdateCountryByID(ctx context.Context, name string, shortCode string, ID int) (Country, error)
	DeleteCountryByID(ctx context.Context, ID int) error
	CheckCountryExists(ctx context.Context, name string, shortCode string) (bool, error)
	IsCountryExists(ctx context.Context, name string, shortCode string) (bool, error)
	GetAllCountriesWithStats(ctx context.Context) ([]CountryResponse, error)
	CountUsersByCountryID(ctx context.Context, countryID int) (int64, error)
}
