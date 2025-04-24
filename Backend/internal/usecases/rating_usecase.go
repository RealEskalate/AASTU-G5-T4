package usecases

// import (
// 	"A2SVHUB/internal/domain"
// 	"context"
	
// )

// type RatingUseCase struct {
// 	repo domain.RatingRepository
// }

// func NewRatingUseCase(repo domain.RatingRepository) *RatingUseCase {
// 	return &RatingUseCase{repo: repo}
// }


// func (u *RatingUseCase) GetAllRatings(ctx context.Context, contestID int) ([]domain.Rating, error) {
// 	ratings, err := u.repo.GetAllRatings(ctx, contestID)
// 	if err != nil {
// 		return nil, err
// 	}
// 	return ratings, nil
// }


// func (u *RatingUseCase) GetRatingByID(ctx context.Context, id int) (*domain.Rating, error) {
// 	rating, err := u.repo.GetRatingByID(ctx, id)
// 	if err != nil {
// 		return nil, err
// 	}
// 	return &rating, nil
// }


// func (u *RatingUseCase) GenerateRatings(ctx context.Context, contestID int) error {
// 	return u.repo.CalculateAndSaveRatings(ctx, contestID)
// }
