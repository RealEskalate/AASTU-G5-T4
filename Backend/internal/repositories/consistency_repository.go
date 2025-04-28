package repositories

import (
	"A2SVHUB/internal/domain"
	"time"

	"gorm.io/gorm"
)

type ConsistencyRepository struct {
	db *gorm.DB
}

// GetConsistencyOfGroup implements domain.OutsideConsistencyRepository.
func (c *ConsistencyRepository) GetConsistencyOfGroup(id int, startDate time.Time, endDate time.Time) []domain.OutsideConsistency {
	var consistencies []domain.OutsideConsistency
	err := c.db.Where("group_id = ? AND date >= ? AND date <= ?", id, startDate, endDate).Find(&consistencies).Error
	if err != nil {
		// Handle error appropriately, e.g., log it or return an empty slice
		return []domain.OutsideConsistency{}
	}
	return consistencies
}

// GetConsistencyOfUser implements domain.OutsideConsistencyRepository.
func (c *ConsistencyRepository) GetConsistencyOfUser(id int, startDate time.Time, endDate time.Time) domain.OutsideConsistency {
	var consistency domain.OutsideConsistency
	err := c.db.Where("user_id = ? AND date >= ? AND date <= ?", id, startDate, endDate).First(&consistency).Error
	if err != nil {
		// Handle error appropriately, e.g., log it or return a default value
		return domain.OutsideConsistency{}
	}
	return consistency
}

func NewConsistencyRepository(db *gorm.DB) domain.OutsideConsistencyRepository {
	return &ConsistencyRepository{db: db}
}
