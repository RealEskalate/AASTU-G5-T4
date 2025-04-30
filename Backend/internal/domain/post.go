package domain

// models/post.go

import "time"

type Post struct {
	ID        int       `gorm:"primaryKey"`
	UserID    int       `gorm:"type:integer"`
	Title     string    `gorm:"type:varchar(255)"`
	Body      string    `gorm:"type:text"`
	CreatedAt time.Time `gorm:"type:timestamp"`
	UpdatedAt time.Time `gorm:"type:timestamp"`
	User      User      `gorm:"foreignKey:UserID"`
}

type PostTag struct {
	ID        int       `gorm:"primaryKey"`
	Name      string    `gorm:"type:varchar(255)"`
	CreatedAt time.Time `gorm:"type:timestamp"`
	UpdatedAt time.Time `gorm:"type:timestamp"`
}

type PostToTag struct {
	ID        int       `gorm:"primaryKey"`
	PostID    int       `gorm:"type:integer"`
	PostTagID int       `gorm:"type:integer"`
	CreatedAt time.Time `gorm:"type:timestamp"`
	UpdatedAt time.Time `gorm:"type:timestamp"`
	Post      Post      `gorm:"foreignKey:PostID"`
	PostTag   PostTag   `gorm:"foreignKey:PostTagID"`
}
