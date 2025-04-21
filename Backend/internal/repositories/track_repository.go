package repositories

import (
    "A2SVHUB/internal/domain"
    "context"
    "fmt"

    "gorm.io/gorm"
)

type TrackRepository struct {
    db *gorm.DB
}

// CreateTrack implements domain.TrackRepository.
func (t *TrackRepository) CreateTrack(ctx context.Context, track domain.Track) (domain.Track, error) {
    var existing domain.Track
    if err := t.db.WithContext(ctx).Where("name = ? AND super_group_id = ?", track.Name, track.SuperGroupID).First(&existing).Error; err == nil {
        return domain.Track{}, fmt.Errorf("track with name '%s' already exists in the super group", track.Name)
    }

    if err := t.db.WithContext(ctx).Create(&track).Error; err != nil {
        return domain.Track{}, err
    }
    return track, nil
}

// GetAllTracks implements domain.TrackRepository.
func (t *TrackRepository) GetAllTracks(ctx context.Context) ([]domain.Track, error) {
    var tracks []domain.Track
    if err := t.db.WithContext(ctx).Find(&tracks).Error; err != nil {
        return nil, err
    }
    return tracks, nil
}

// FindTrackByID implements domain.TrackRepository.
func (t *TrackRepository) FindTrackByID(ctx context.Context, ID int) (domain.Track, error) {
    var track domain.Track
    if err := t.db.WithContext(ctx).First(&track, ID).Error; err != nil {
        if err == gorm.ErrRecordNotFound {
            return domain.Track{}, fmt.Errorf("track with ID %d not found", ID)
        }
        return domain.Track{}, err
    }
    return track, nil
}

// FindTracksByName implements domain.TrackRepository.
func (t *TrackRepository) FindTracksByName(ctx context.Context, name string) ([]domain.Track, error) {
    var tracks []domain.Track
    if err := t.db.WithContext(ctx).Where("name = ?", name).Find(&tracks).Error; err != nil {
        return nil, err
    }
    return tracks, nil
}

// UpdateTrack implements domain.TrackRepository.
func (t *TrackRepository) UpdateTrack(ctx context.Context, track domain.Track) (domain.Track, error) {
    var existingTrack domain.Track
    if err := t.db.WithContext(ctx).First(&existingTrack, track.ID).Error; err != nil {
        if err == gorm.ErrRecordNotFound {
            return domain.Track{}, fmt.Errorf("track with ID %d not found", track.ID)
        }
        return domain.Track{}, err
    }

    existingTrack.Name = track.Name
    existingTrack.SuperGroupID = track.SuperGroupID
    existingTrack.Active = track.Active

    if err := t.db.WithContext(ctx).Save(&existingTrack).Error; err != nil {
        return domain.Track{}, err
    }
    return existingTrack, nil
}

// DeleteTrack implements domain.TrackRepository.
func (t *TrackRepository) DeleteTrack(ctx context.Context, ID int) error {
    var track domain.Track
    if err := t.db.WithContext(ctx).First(&track, ID).Error; err != nil {
        if err == gorm.ErrRecordNotFound {
            return fmt.Errorf("track with ID %d not found", ID)
        }
        return err
    }

    if err := t.db.WithContext(ctx).Delete(&track).Error; err != nil {
        return err
    }
    return nil
}

// NewTrackRepository creates a new instance of TrackRepository.
func NewTrackRepository(db *gorm.DB) domain.TrackRepository {
    return &TrackRepository{db: db}
}