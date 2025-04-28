package domain

import (
	"context"
	"time"
)

type APIToken struct {
	ID        int       `gorm:"primaryKey"`
	UserID    int       `gorm:"type:integer"`
	Name      string    `gorm:"type:varchar(255)"`
	Type      string    `gorm:"type:varchar(255)"`
	Token     string    `gorm:"type:varchar(64)"`
	ExpiresAt time.Time `gorm:"type:timestamp"`
	CreatedAt time.Time `gorm:"type:timestamp"`
	User      User      `gorm:"foreignKey:UserID"`
}

type AssistantMessage struct {
	ID          int       `gorm:"primaryKey"`
	UserID      int       `gorm:"type:integer"`
	Question    string    `gorm:"type:text"`
	Answer      string    `gorm:"type:text"`
	Feedback    string    `gorm:"type:text"`
	Session     string    `gorm:"type:varchar(255)"`
	RawResponse string    `gorm:"type:text"`
	CreatedAt   time.Time `gorm:"type:timestamp"`
	UpdatedAt   time.Time `gorm:"type:timestamp"`
	User        User      `gorm:"foreignKey:UserID"`
}

type User struct {
	ID                     int       `gorm:"primaryKey"`
	RoleID                 int       `gorm:"type:integer"`
	Name                   string    `gorm:"type:varchar(255)" validate:"required,min=3,max=255"`
	CountryID              int       `gorm:"type:integer"`
	University             string    `gorm:"type:varchar(255)" validate:"required,min=3,max=255"`
	Email                  string    `gorm:"type:varchar(255)" validate:"required,email"`
	Leetcode               string    `gorm:"type:varchar(255)" validate:"omitempty,url"`
	Codeforces             string    `gorm:"type:varchar(255)" validate:"omitempty,url"`
	Github                 string    `gorm:"type:varchar(255)" validate:"omitempty,url"`
	AvatarURL              string    `gorm:"column:avatar_url"`
	PreferredLanguage      string    `gorm:"type:varchar(255)" validate:"omitempty,max=255"`
	Hackerrank             string    `gorm:"type:varchar(255)" validate:"omitempty,url"`
	GroupID                int       `gorm:"type:integer"`
	Phone                  string    `gorm:"type:varchar(255)" validate:"omitempty,e164"`
	TelegramUsername       string    `gorm:"type:varchar(255)" validate:"omitempty"`
	TelegramUID            string    `gorm:"type:varchar(255)" validate:"omitempty"`
	Linkedin               string    `gorm:"type:varchar(255)" validate:"omitempty,url"`
	StudentID              string    `gorm:"type:varchar(255)" validate:"omitempty"`
	ShortBio               string    `gorm:"type:text" validate:"omitempty"`
	Instagram              string    `gorm:"type:varchar(255)" validate:"omitempty,url"`
	Birthday               time.Time `gorm:"type:timestamp" validate:"required"`
	CV                     string    `gorm:"type:varchar(255)" validate:"omitempty,url"`
	JoinedDate             time.Time `gorm:"type:timestamp"`
	ExpectedGraduationDate time.Time `gorm:"type:timestamp"`
	MentorName             string    `gorm:"type:varchar(255)" validate:"omitempty,max=255"`
	TshirtColor            string    `gorm:"type:varchar(255)" validate:"omitempty"`
	TshirtSize             string    `gorm:"type:varchar(255)" validate:"omitempty"`
	Gender                 string    `gorm:"type:varchar(255)" validate:"omitempty,oneof=male female other"`
	CodeOfConduct          string    `gorm:"type:varchar(255)" validate:"omitempty"`
	Password               string    `gorm:"type:varchar(255)" validate:"required,min=8,max=32"`
	CreatedAt              time.Time `gorm:"type:timestamp"`
	UpdatedAt              time.Time `gorm:"type:timestamp"`
	Config                 string    `gorm:"type:text"`
	Department             string    `gorm:"type:varchar(255)" validate:"omitempty"`
	Inactive               bool      `gorm:"default:false"`
	Role                   Role      `gorm:"foreignKey:RoleID"`
	Country                Country   `gorm:"foreignKey:CountryID"`
	Group                  Group     `gorm:"foreignKey:GroupID"`
}

type RecentAction struct {
	ID          int       `gorm:"primaryKey"`
	UserID      int       `gorm:"type:integer"`
	Type        string    `gorm:"type:varchar(255)"`
	Description string    `gorm:"type:varchar(255)"`
	CreatedAt   time.Time `gorm:"type:timestamp"`
	UpdatedAt   time.Time `gorm:"type:timestamp"`
	User        User      `gorm:"foreignKey:UserID"`
}

//
//

type Notification struct {
	ID          int       `gorm:"primaryKey"`
	Type        string    `gorm:"type:varchar(255)"`
	Description string    `gorm:"type:varchar(255)"`
	Seen        bool      `gorm:"type:boolean"`
	UserID      int       `gorm:"type:integer"`
	CreatedAt   time.Time `gorm:"type:timestamp"`
	UpdatedAt   time.Time `gorm:"type:timestamp"`
	User        User      `gorm:"foreignKey:UserID"`
}

type OutsideConsistency struct {
	ID         int       `gorm:"primaryKey"`
	UserID     int       `gorm:"type:integer"`
	ForDate    time.Time `gorm:"type:date"`
	SolveCount int       `gorm:"type:integer"`
	CreatedAt  time.Time `gorm:"type:timestamp"`
	UpdatedAt  time.Time `gorm:"type:timestamp"`
	User       User      `gorm:"foreignKey:UserID"`
}

type UserResponse struct {
	ID                int       `json:"id"`
	RoleID            int       `json:"role_id"`
	Name              string    `json:"name"`
	CountryID         int       `json:"country_id"`
	University        string    `json:"university"`
	Email             string    `json:"email"`
	Leetcode          string    `json:"leetcode,omitempty"`
	Codeforces        string    `json:"codeforces,omitempty"`
	Github            string    `json:"github,omitempty"`
	AvatarURL         string    `gorm:"column:avatar_url"`
	PreferredLanguage string    `json:"preferred_language,omitempty"`
	Hackerrank        string    `json:"hackerrank,omitempty"`
	GroupID           int       `json:"group_id"`
	Phone             string    `json:"phone,omitempty"`
	TelegramUsername  string    `json:"telegram_username,omitempty"`
	TelegramUID       string    `json:"telegram_uid,omitempty"`
	Linkedin          string    `json:"linkedin,omitempty"`
	StudentID         string    `json:"student_id,omitempty"`
	ShortBio          string    `json:"short_bio,omitempty"`
	Instagram         string    `json:"instagram,omitempty"`
	Birthday          time.Time `json:"birthday"`
	Gender            string    `json:"gender,omitempty"`
	Department        string    `json:"department,omitempty"`
	Role              string    `json:"role"`
	Country           string    `json:"country"`
}

type UserRepository interface {
	GetAllUsers(ctx context.Context) ([]User, error)
	GetUserByID(ctx context.Context, id int) (User, error)
	CreateUser(ctx context.Context, user User) (User, error)
	UpdateUser(ctx context.Context, id int, updatedUser User) (User, error)
	DeleteUser(ctx context.Context, id int) error
	CreateUsers(ctx context.Context, users []User) ([]User, error)
	GetUsersByGroup(ctx context.Context, groupID int) ([]User, error)
	UpdateAvatar(ctx context.Context, userIDs []int, imageURL string) error
	GetUserSubmissions(ctx context.Context, userID int) ([]Submission, float64, int64, error)
}

type UserUseCase interface {
	GetAllUsers(ctx context.Context) ([]User, error)
	GetUserByID(ctx context.Context, id int) (User, error)
	CreateUser(ctx context.Context, user User) (User, error)
	UpdateUser(ctx context.Context, id int, user User) (User, error)
	DeleteUser(ctx context.Context, id int) error
	CreateUsers(ctx context.Context, users []User) ([]User, error)
	GetUsersByGroup(ctx context.Context, groupID int) ([]User, error)
	UpdateAvatar(ctx context.Context, userID int, imageURL string) error
	GetUserSubmissions(ctx context.Context, userID int) ([]Submission, float64, int64, error)
}
