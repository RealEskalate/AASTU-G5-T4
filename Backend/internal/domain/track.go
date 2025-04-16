// package domain

// import (
//     "context"
//     "time"
// )

// type Track struct {
//     ID           int        `gorm:"primaryKey"`
//     Name         string     `gorm:"type:varchar(255)"`
//     CreatedAt    time.Time  `gorm:"type:timestamp"`
//     UpdatedAt    time.Time  `gorm:"type:timestamp"`
//     Active       bool       `gorm:"default:true"`
//     SuperGroupID int        `gorm:"type:integer"`
//     SuperGroup   SuperGroup `gorm:"foreignKey:SuperGroupID"`
// }

// type TrackRepository interface {
//     GetAllTracks(ctx context.Context) ([]Track, error)
//     CreateTrack(ctx context.Context, name string, superGroupID int) (Track, error)
//     UpdateTrack(ctx context.Context, name string, ID int) (Track, error)
//     DeleteTrack(ctx context.Context, ID int) error
//     FindTracksByName(ctx context.Context, name string) ([]Track, error)
//     FindTrackByID(ctx context.Context, ID int) (Track, error)
// }

//	type TrackUseCase interface {
//	    GetAllTracks(ctx context.Context) ([]Track, error)
//	    CreateTrack(ctx context.Context, name string, superGroupID int) (Track, error)
//	    UpdateTrack(ctx context.Context, name string, ID int) (Track, error)
//	    DeleteTrack(ctx context.Context, ID int) error
//	    FindTracksByName(ctx context.Context, name string) ([]Track, error)
//	    FindTrackByID(ctx context.Context, ID int) (Track, error)
//	}
package domain

import "context"

type Track struct {
	ID           int
	Name         string
	SuperGroupID int
}

type TrackRepository interface {
	GetAllTracks(ctx context.Context) ([]Track, error)
	CreateTrack(ctx context.Context, name string, superGroupID int) (Track, error)
	UpdateTrack(ctx context.Context, name string, ID int) (Track, error)
	DeleteTrack(ctx context.Context, ID int) error
	FindTracksByName(ctx context.Context, name string) ([]Track, error)
	FindTrackByID(ctx context.Context, ID int) (Track, error)
}

type TrackUseCase interface {
	GetAllTracks(ctx context.Context) ([]Track, error)
	CreateTrack(ctx context.Context, name string, superGroupID int) (Track, error)
	UpdateTrack(ctx context.Context, name string, ID int) (Track, error)
	DeleteTrack(ctx context.Context, ID int) error
	FindTracksByName(ctx context.Context, name string) ([]Track, error)
	FindTrackByID(ctx context.Context, ID int) (Track, error)
}
