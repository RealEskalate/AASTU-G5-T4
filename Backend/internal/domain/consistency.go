package domain

import "time"

type OutsideConsistency struct {
	ID         int       `gorm:"primaryKey"`
	UserID     int       `gorm:"type:integer"`
	ForDate    time.Time `gorm:"type:date"`
	SolveCount int       `gorm:"type:integer"`
	CreatedAt  time.Time `gorm:"type:timestamp"`
	UpdatedAt  time.Time `gorm:"type:timestamp"`
	User       User      `gorm:"foreignKey:UserID"`
}

type OutsideConsistencyRepository interface {
	GetConsistencyOfUser(id int, startDate time.Time, endDate time.Time) OutsideConsistency
	GetConsistencyOfGroup(id int, startDate time.Time, endDate time.Time) []OutsideConsistency
}

type OutsideConsistencyUseCase interface {
	GetConsistencyOfUser(id int, startDate time.Time, endDate time.Time) OutsideConsistency
	GetConsistencyOfGroup(id int, startDate time.Time, endDate time.Time) []OutsideConsistency
}
