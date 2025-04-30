package repositories

import (
	"A2SVHUB/internal/domain"
	"context"
	"errors"
	"fmt"

	"gorm.io/gorm"
)

type UserRepository struct {
	db gorm.DB
}

func NewUserRepository(db gorm.DB) domain.UserRepository {
	return &UserRepository{
		db: db,
	}

}

func (r *UserRepository) GetAllUsers(ctx context.Context) ([]domain.User, error) {
	var users []domain.User
	if err := r.db.WithContext(ctx).Find(&users).Error; err != nil {
		return nil, err
	}
	return users, nil
}

func (r *UserRepository) GetUserByID(ctx context.Context, id int) (domain.User, error) {
	var user domain.User
	if err := r.db.WithContext(ctx).First(&user, id).Error; err != nil {
		if err == gorm.ErrRecordNotFound {
			return domain.User{}, fmt.Errorf("no user found with ID %d", id)
		}
		return user, err
	}
	return user, nil
}

func (r *UserRepository) CreateUser(ctx context.Context, user domain.User) (domain.User, error) {

	var existing domain.User
	if err := r.db.WithContext(ctx).Where("email = ?", user.Email).First(&existing).Error; err == nil {
		return domain.User{}, fmt.Errorf("user with email '%s' already exists", user.Email)
	}
	if err := r.db.WithContext(ctx).Create(&user).Error; err != nil {
		return domain.User{}, err
	}
	return user, nil
}

func (r *UserRepository) UpdateUser(ctx context.Context, id int, updatedUser domain.User) (domain.User, error) {
	var existingUser domain.User
	if err := r.db.WithContext(ctx).First(&existingUser, id).Error; err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return domain.User{}, fmt.Errorf("no user found with ID %d", id)
		}
		return domain.User{}, err
	}

	if updatedUser.Email != existingUser.Email {
		var emailUser domain.User
		if err := r.db.WithContext(ctx).Where("email = ? AND id != ?", updatedUser.Email, id).First(&emailUser).Error; err == nil {
			return domain.User{}, fmt.Errorf("another user with email '%s' already exists", updatedUser.Email)
		}
	}

	updatedUser.ID = id

	if err := r.db.WithContext(ctx).Model(&existingUser).Updates(updatedUser).Error; err != nil {
		return domain.User{}, err
	}

	return updatedUser, nil
}

func (r *UserRepository) DeleteUser(ctx context.Context, id int) error {
	var user domain.User
	if err := r.db.WithContext(ctx).First(&user, id).Error; err != nil {
		if err == gorm.ErrRecordNotFound {
			return fmt.Errorf("no user found with ID %d", id)
		}
		return err
	}

	if err := r.db.WithContext(ctx).Delete(&user).Error; err != nil {
		return err
	}
	return nil
}

func (r *UserRepository) CreateUsers(ctx context.Context, users []domain.User) ([]domain.User, error) {

	for _, u := range users {
		var existing domain.User
		if err := r.db.WithContext(ctx).Where("email = ?", u.Email).First(&existing).Error; err == nil {
			return nil, fmt.Errorf("user with email '%s' already exists", u.Email)
		}
	}

	if err := r.db.WithContext(ctx).Create(&users).Error; err != nil {
		return nil, err
	}

	return users, nil
}

func (r *UserRepository) GetUsersByGroup(ctx context.Context, groupID int) ([]domain.User, error) {
	var users []domain.User
	if err := r.db.WithContext(ctx).Where("group_id = ?", groupID).Find(&users).Error; err != nil {
		return nil, err
	}
	return users, nil
}
func (r *UserRepository) UpdateAvatar(ctx context.Context, userIDs []int, imageURL string) error {
	if len(userIDs) == 0 {
		return fmt.Errorf("no user IDs provided for avatar update")
	}

	if err := r.db.WithContext(ctx).
		Model(&domain.User{}).
		Where("id IN ?", userIDs).
		Update("avatar_url", imageURL).Error; err != nil {
		return err
	}

	return nil
}
func (r *UserRepository) CountUsersByCountry(ctx context.Context, countryID int) (int, error) {
	var count int64
	err := r.db.WithContext(ctx).
		Model(&domain.User{}).
		Where("country_id = ?", countryID).
		Count(&count).Error
	return int(count), err

}
func (r *UserRepository) GetUserSubmissions(ctx context.Context, userID int) ([]domain.Submission, float64, int64, error) {
	var submissions []domain.Submission
	var totalTimeSpent int64

	if err := r.db.WithContext(ctx).
		Where("user_id = ?", userID).
		Find(&submissions).Error; err != nil {
		return nil, 0, 0, err
	}

	for _, submission := range submissions {
		totalTimeSpent += submission.TimeSpent
	}

	totalProblems := len(submissions)

	return submissions, float64(totalProblems), totalTimeSpent, nil
}
