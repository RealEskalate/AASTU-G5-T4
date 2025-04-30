package dtos

import "time"

type InviteDTO struct {
	ID        int       `gorm:"primaryKey"`
	Key       string    `gorm:"type:varchar(255)"`
	RoleID    int       `gorm:"type:integer"`
	UserID    int       `gorm:"type:integer"`
	GroupID   int       `gorm:"type:integer"`
	Used      bool      `gorm:"default:false"`
	CreatedAt time.Time `gorm:"type:timestamp"`
	UpdatedAt time.Time `gorm:"type:timestamp"`
}

type CreateInviteDTO struct {
	Email    string `json:"email" binding:"required,email"`
	RoleID   int    `json:"role_id" binding:"required"`
	GroupID  int    `json:"group_id" binding:"required"`
	CountryID int   `json:"country_id" binding:"required"`
}

type CreateBatchInviteDTO struct {
	Emails    []string `json:"emails" binding:"required"`
	RoleID   int    `json:"role_id" binding:"required"`
	GroupID  int    `json:"group_id" binding:"required"`
	CountryID int   `json:"country_id" binding:"required"`
}

type InviteExistingUserDTO struct {
	ID     int       `json:"id"`
	RoleID    int       `json:"role_id"`
	GroupID   int       `json:"group_id"`
	CountryID int       `json:"country_id"`
}


type InvitedUserDTO struct {
	ID                     int       `gorm:"primaryKey"`
	RoleID                 int       `gorm:"type:integer"`
	Name                   string    `gorm:"type:varchar(255)"`
	CountryID              int       `gorm:"type:integer"`
	University             string    `gorm:"type:varchar(255)"`
	Email                  string    `gorm:"type:varchar(255)"`
	Leetcode               string    `gorm:"type:varchar(255)"`
	Codeforces             string    `gorm:"type:varchar(255)"`
	Github                 string    `gorm:"type:varchar(255)"`
	Photo                  string    `gorm:"type:varchar(255)"`
	PreferredLanguage      string    `gorm:"type:varchar(255)"`
	Hackerrank             string    `gorm:"type:varchar(255)"`
	GroupID                int       `gorm:"type:integer"`
	Phone                  string    `gorm:"type:varchar(255)"`
	TelegramUsername       string    `gorm:"type:varchar(255)"`
	TelegramUID            string    `gorm:"type:varchar(255)"`
	Linkedin               string    `gorm:"type:varchar(255)"`
	StudentID              string    `gorm:"type:varchar(255)"`
	ShortBio               string    `gorm:"type:text"`
	Instagram              string    `gorm:"type:varchar(255)"`
	Birthday               time.Time `gorm:"type:timestamp"`
	CV                     string    `gorm:"type:varchar(255)"`
	JoinedDate             time.Time `gorm:"type:timestamp"`
	ExpectedGraduationDate time.Time `gorm:"type:timestamp"`
	MentorName             string    `gorm:"type:varchar(255)"`
	TshirtColor            string    `gorm:"type:varchar(255)"`
	TshirtSize             string    `gorm:"type:varchar(255)"`
	Gender                 string    `gorm:"type:varchar(255)"`
	CodeOfConduct          string    `gorm:"type:varchar(255)"`
	Password               string    `gorm:"type:varchar(255)"`
	CreatedAt              time.Time `gorm:"type:timestamp"`
	UpdatedAt              time.Time `gorm:"type:timestamp"`
	Config                 string    `gorm:"type:text"`
	Department             string    `gorm:"type:varchar(255)"`
	Inactive               bool      `gorm:"default:false"`
}
