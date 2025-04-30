package repositories

import (
	"A2SVHUB/internal/domain"
	"context"
	"fmt"

	"gorm.io/gorm"
)

type ProblemRepository struct {
	db gorm.DB
}

// CreateProblem implements domain.ProblemRepository.
func (p *ProblemRepository) CreateProblem(ctx context.Context, problem domain.Problem) (domain.Problem, error) {
	fmt.Println(&problem, "////////////////////")
	if err := p.db.WithContext(ctx).Create(&problem).Error; err != nil {
		return domain.Problem{}, err
	}
	return problem, nil
}

// DeleteProblem implements domain.ProblemRepository.
func (p *ProblemRepository) DeleteProblem(ctx context.Context, id int) error {
	if err := p.db.WithContext(ctx).Delete(&domain.Problem{}, id).Error; err != nil {
		return err
	}
	return nil
}

// GetProblemByID implements domain.ProblemRepository.
func (p *ProblemRepository) GetProblemByID(ctx context.Context, id int) (domain.Problem, error) {
	var problem domain.Problem
	if err := p.db.WithContext(ctx).First(&problem, id).Error; err != nil {
		return domain.Problem{}, err
	}
	return problem, nil
}

// GetProblemByName implements domain.ProblemRepository.
func (p *ProblemRepository) GetProblemByName(ctx context.Context, name string) ([]domain.Problem, error) {
	var problem []domain.Problem
	if err := p.db.WithContext(ctx).Where("name LIKE ?", "%"+name+"%").First(&problem).Error; err != nil {
		return []domain.Problem{}, err
	}
	return problem, nil
}

// UpdateProblem implements domain.ProblemRepository.
func (p *ProblemRepository) UpdateProblem(ctx context.Context, problem domain.Problem) error {
	if err := p.db.WithContext(ctx).Save(&problem).Error; err != nil {
		return err
	}
	return nil
}
func (p *ProblemRepository) GetProblemsByNameAndFilters(ctx context.Context, name string, filter map[string]interface{}) ([]domain.Problem, error) {
	var problems []domain.Problem
	query := p.db.WithContext(ctx)

	// Add name filter
	if name != "" {
		query = query.Where("name LIKE ?", "%"+name+"%")
	}

	// Handle pagination
	limit, ok := filter["limit"].(int)
	if !ok || limit <= 0 {
		limit = 50 // Default limit
	}

	page, ok := filter["page"].(int)
	if !ok || page <= 0 {
		page = 1 // Default page
	}

	// Remove pagination keys from filter
	delete(filter, "limit")
	delete(filter, "page")

	// Add additional filters
	for key, value := range filter {
		query = query.Where("LOWER("+key+") LIKE LOWER(?)", "%"+fmt.Sprintf("%v", value)+"%")
	}

	offset := (page - 1) * limit
	query = query.Limit(limit).Offset(offset)
	sql := query.Statement.SQL.String()
	fmt.Println("Generated SQL Query:", sql)
	// Execute query
	if err := query.Find(&problems).Error; err != nil {
		return nil, err
	}
	return problems, nil
}

func NewProblemRepository(db gorm.DB) domain.ProblemRepository {
	return &ProblemRepository{
		db: db,
	}
}
