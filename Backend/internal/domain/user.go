package domain

// models/user.go

import "time"

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
