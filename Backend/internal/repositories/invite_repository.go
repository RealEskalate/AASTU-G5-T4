package repositories

import (
	"A2SVHUB/internal/domain"
	"A2SVHUB/internal/dtos"
	"context"
	"fmt"
	"time"

	"gorm.io/gorm"
)

type InviteRepository struct {
	DB *gorm.DB
}

func NewInviteRepository(db *gorm.DB) *InviteRepository {
	return &InviteRepository{
		DB: db,
	}
}

func (r *InviteRepository) GetUserByEmail(email string, ctx context.Context) (*domain.User, error) {
	var user domain.User
	if err := r.DB.WithContext(ctx).Where("email = ?", email).First(&user).Error; err != nil {
		return nil, err
	}
	return &user, nil
}

func (r *InviteRepository) GetUserByID(id int, ctx context.Context) (*domain.User, error) {
	var user domain.User
	if err := r.DB.WithContext(ctx).Where("id = ?", id).First(&user).Error; err != nil {
		return nil, err
	}
	return &user, nil
}

func (r *InviteRepository) CreateUser(invite dtos.CreateInviteDTO, ctx context.Context) (*domain.User, error) {
	var user = domain.User{
		Email: invite.Email,
		RoleID: invite.RoleID,
		GroupID: invite.GroupID,
		CountryID: invite.CountryID,
	}
	
	if err := r.DB.WithContext(ctx).Create(&user).Error; err != nil {
		return nil, err
	}
	return &user, nil
}


func (r *InviteRepository) CreateUsers(invites dtos.CreateBatchInviteDTO, ctx context.Context) ([]domain.User, error) {
    var users []domain.User

    err := r.DB.WithContext(ctx).Transaction(func(tx *gorm.DB) error {
        var existingUsers []domain.User
        if err := tx.Where("email IN ?", invites.Emails).Find(&existingUsers).Error; err != nil {
            return fmt.Errorf("failed to check existing emails: %v", err)
        }
        existingEmailMap := make(map[string]bool)
        for _, user := range existingUsers {
            existingEmailMap[user.Email] = true
        }
        for _, email := range invites.Emails {
            if existingEmailMap[email] {
                continue
            }
            user := domain.User{
                Email:     email,
                RoleID:    invites.RoleID,
                GroupID:   invites.GroupID,
				CountryID: invites.CountryID,
                CreatedAt: time.Now(),
                UpdatedAt: time.Now(),
            }

            if err := tx.Create(&user).Error; err != nil {
                return fmt.Errorf("failed to create user with email %s: %v", email, err)
            }

            users = append(users, user)
        }
        return nil
    })

    if err != nil {
        return nil, err
    }

    return users, nil
}

func (r *InviteRepository) CreateInvite(invite domain.Invite, ctx context.Context) (*domain.Invite, error) {
	if err := r.DB.WithContext(ctx).Create(&invite).Error; err != nil {
		return nil, err
	}
	return &invite, nil
}

func (r *InviteRepository) CreateInvites(invites []domain.Invite, ctx context.Context) ([]domain.Invite, error) {
    var createdInvites []domain.Invite

	err := r.DB.WithContext(ctx).Transaction(func(tx *gorm.DB) error {
        for _, invite := range invites {
            if err := tx.Create(&invite).Error; err != nil {
				return fmt.Errorf("failed to create invite for user %d: %v", invite.UserID, err)
            }
            createdInvites = append(createdInvites, invite)
        }
        return nil
    })

    if err != nil {
        return []domain.Invite{}, err
    }
    return createdInvites, nil
}

func (r *InviteRepository) GetInviteByKey(key string, ctx context.Context) (*domain.Invite, error) {
	var invite domain.Invite
	if err := r.DB.WithContext(ctx).Where("key = ?", key).First(&invite).Error; err != nil {
		return nil, err
	}
	return &invite, nil
}

func (r *InviteRepository) UpdateInviteStatus(id int, ctx context.Context) error {
	var invite domain.Invite
	if err := r.DB.WithContext(ctx).Model(&invite).Where("id = ?", id).Update("used", true).Error; err != nil {
		return err
	}
	return nil
}