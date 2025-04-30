package usecases

import (
	"A2SVHUB/internal/domain"
	"context"
	"errors"
)

type UserUseCase struct {
	UserRepository domain.UserRepository
}

func NewUserUseCase(userRepo domain.UserRepository) domain.UserUseCase {
	return &UserUseCase{
		UserRepository: userRepo,
	}
}

func (u UserUseCase) GetAllUsers(ctx context.Context) ([]domain.User, error) {
	return u.UserRepository.GetAllUsers(ctx)
}

func (u UserUseCase) GetUserByID(ctx context.Context, id int) (domain.User, error) {
	user, err := u.UserRepository.GetUserByID(ctx, id)
	if err != nil {
		return domain.User{}, err
	}
	if user.ID == 0 {
		return domain.User{}, errors.New("user not found")
	}
	return user, nil
}

func (u UserUseCase) CreateUser(ctx context.Context, user domain.User) (domain.User, error) {

	return u.UserRepository.CreateUser(ctx, user)
}

func (u UserUseCase) UpdateUser(ctx context.Context, id int, user domain.User) (domain.User, error) {
	existingUser, err := u.UserRepository.GetUserByID(ctx, id)
	if err != nil {
		return domain.User{}, err
	}
	if existingUser.ID == 0 {
		return domain.User{}, errors.New("user not found")
	}
	return u.UserRepository.UpdateUser(ctx, id, user)
}

func (u UserUseCase) DeleteUser(ctx context.Context, id int) error {
	user, err := u.UserRepository.GetUserByID(ctx, id)
	if err != nil {
		return err
	}
	if user.ID == 0 {
		return errors.New("user not found")
	}
	return u.UserRepository.DeleteUser(ctx, id)
}

func (u UserUseCase) CreateUsers(ctx context.Context, users []domain.User) ([]domain.User, error) {
	return u.UserRepository.CreateUsers(ctx, users)
}

func (u *UserUseCase) GetUsersByGroup(ctx context.Context, groupID int) ([]domain.User, error) {
	return u.UserRepository.GetUsersByGroup(ctx, groupID)
}

//

func (uc *UserUseCase) UpdateAvatar(ctx context.Context, userID int, imageURL string) error {

	return uc.UserRepository.UpdateAvatar(ctx, []int{userID}, imageURL)
}

func (uc *UserUseCase) GetUserSubmissions(ctx context.Context, userID int) ([]domain.Submission, float64, int64, error) {
	// First check if user exists
	user, err := uc.UserRepository.GetUserByID(ctx, userID)
	if err != nil {
		return nil, 0, 0, err
	}
	if user.ID == 0 {
		return nil, 0, 0, errors.New("user not found")
	}

	return uc.UserRepository.GetUserSubmissions(ctx, userID)
}
