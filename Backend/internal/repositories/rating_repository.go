 package repositories

// import (
// 	"A2SVHUB/internal/domain"
// 	"context"

// 	"time"


// 	"gorm.io/gorm"
// )

// type RatingRepository struct {
// 	db *gorm.DB
// }

// func NewRatingRepository(db *gorm.DB) domain.RatingRepository {
// 	return &RatingRepository{
// 		db: db,
// 	}
// }

// func (r *RatingRepository) CalculateAndSaveRatings(ctx context.Context, contestID int) error {
// 	type UserResult struct {
// 		UserID  int
// 		Solved  int
// 		Penalty int
// 	}

// 	var results []UserResult

// 	err := r.db.WithContext(ctx).
// 		Raw(`
// 			SELECT 
// 			s.user_id,
// 			COUNT(DISTINCT s.problem_id) AS solved,
// 			COALESCE(SUM(s.penalty), 0) AS penalty
// 			FROM submissions s
// 			INNER JOIN problems p ON s.problem_id = p.id
// 			WHERE s.is_solved = TRUE AND p.contest_id = ?
// 			GROUP BY s.user_id
// 			ORDER BY solved DESC, penalty ASC
// 		`, contestID).
// 		Scan(&results).Error

// 	if err != nil {
// 		return err
// 	}


// 	if err := r.db.WithContext(ctx).Where("contest_id = ?", contestID).Delete(&domain.Rating{}).Error; err != nil {
// 		return err
// 	}

// 	for rank, res := range results {
// 		rating := domain.Rating{
// 			ContestID: contestID,
// 			UserID:    res.UserID,
// 			Solved:    res.Solved,
// 			Penalty:   res.Penalty,
// 			Rank:      rank + 1,
// 			Points:    res.Solved * 100, 
// 			CreatedAt: time.Now(),
// 			UpdatedAt: time.Now(),
// 		}

// 		if err := r.db.WithContext(ctx).Create(&rating).Error; err != nil {
// 			return err
// 		}
// 	}

// 	return nil
// }


// func (r *RatingRepository) GetAllRatings(ctx context.Context, contestID int) ([]domain.Rating, error) {
// 	var ratings []domain.Rating
// 	if err := r.db.WithContext(ctx).Where("contest_id = ?", contestID).Find(&ratings).Error; err != nil {
// 		return nil, err
// 	}
// 	return ratings, nil
// }


// func (r *RatingRepository) GetRatingByID(ctx context.Context, id int) (domain.Rating, error) {
// 	var rating domain.Rating
// 	if err := r.db.WithContext(ctx).First(&rating, id).Error; err != nil {
// 		return domain.Rating{}, err
// 	}
// 	return rating, nil
// }

