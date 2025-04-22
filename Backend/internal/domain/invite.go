package domain

import (
	"A2SVHUB/internal/dtos"
	"context"
	"time"
)

type Invite struct {
	ID        int       `gorm:"primaryKey"`
	Key       string    `gorm:"type:varchar(255)"`
	RoleID    int       `gorm:"type:integer"`
	UserID    int       `gorm:"type:integer"`
	GroupID   int       `gorm:"type:integer"`
	Used      bool      `gorm:"default:false"`
	CreatedAt time.Time `gorm:"type:timestamp"`
	UpdatedAt time.Time `gorm:"type:timestamp"`
	Role      Role      `gorm:"foreignKey:RoleID"`
	User      User      `gorm:"foreignKey:UserID"`
	Group     Group     `gorm:"foreignKey:GroupID"`
}


type InviteRepository interface {
	GetUserByEmail(email string, ctx context.Context) (*User, error)
	CreateUser(invite dtos.CreateInviteDTO, ctx context.Context) (*User, error)
	CreateUsers(invites dtos.CreateBatchInviteDTO, ctx context.Context) ([]User, error)
	CreateInvite(invite Invite, ctx context.Context) (*Invite, error)
	CreateInvites(invites []Invite, ctx context.Context) ([]Invite, error)
	GetInviteByKey(key string, ctx context.Context) (*Invite, error)
	GetUserByID(id int, ctx context.Context) (*User, error)
	UpdateInviteStatus(id int, ctx context.Context) error 
}

type InviteUseCase interface {
	CreateInvite(invite dtos.CreateInviteDTO) (*dtos.InviteDTO, *ErrorResponse)	
	CreateInvites(invites dtos.CreateBatchInviteDTO) ([]dtos.InviteDTO, *ErrorResponse)
	AcceptInvite(token string) (*dtos.InvitedUserDTO, *ErrorResponse)
	InviteExistingUser(invite dtos.InviteExistingUserDTO) (*dtos.InviteDTO, *ErrorResponse)
}