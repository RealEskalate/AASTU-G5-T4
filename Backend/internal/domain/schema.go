package domain

// models/schema.go

import "time"

type AdonisSchema struct {
	ID            int       `gorm:"primaryKey"`
	Name          string    `gorm:"type:varchar(255)"`
	Batch         int       `gorm:"type:integer"`
	MigrationTime time.Time `gorm:"default:CURRENT_TIMESTAMP"`
}

type AdonisSchemaVersions struct {
	Version int `gorm:"primaryKey"`
}

type RateLimit struct {
	Key    string `gorm:"primaryKey;type:varchar(255)"`
	Points int    `gorm:"type:integer"`
	Expire int64  `gorm:"type:bigint"`
}

type Cache struct {
	ID         int       `gorm:"primaryKey"`
	Identifier string    `gorm:"type:varchar(255)"`
	Content    string    `gorm:"type:text"`
	CreatedAt  time.Time `gorm:"type:timestamp"`
	UpdatedAt  time.Time `gorm:"type:timestamp"`
}
