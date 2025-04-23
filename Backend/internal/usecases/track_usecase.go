package usecases

import (
    "A2SVHUB/internal/domain"
    "context"
    "errors"
)

type TrackUseCase struct {
    TrackRepository domain.TrackRepository
}

// CreateTrack implements domain.TrackUseCase.
func (t TrackUseCase) CreateTrack(ctx context.Context, track domain.Track) (domain.Track, error) {
    if track.Name == "" {
        return domain.Track{}, errors.New("track name cannot be empty")
    }
    if track.SuperGroupID == 0 {
        return domain.Track{}, errors.New("super group ID cannot be zero")
    }

    // Check if the track already exists
    existingTracks, err := t.TrackRepository.FindTracksByName(ctx, track.Name)
    if err != nil {
        return domain.Track{}, err
    }
    for _, existingTrack := range existingTracks {
        if existingTrack.SuperGroupID == track.SuperGroupID {
            return domain.Track{}, errors.New("track with the same name already exists in the super group")
        }
    }

    return t.TrackRepository.CreateTrack(ctx, track)
}

// DeleteTrack implements domain.TrackUseCase.
func (t TrackUseCase) DeleteTrack(ctx context.Context, ID int) error {
    track, err := t.TrackRepository.FindTrackByID(ctx, ID)
    if err != nil {
        return err
    }
    if track.ID == 0 {
        return errors.New("track not found")
    }
    return t.TrackRepository.DeleteTrack(ctx, ID)
}

// FindTrackByID implements domain.TrackUseCase.
func (t TrackUseCase) FindTrackByID(ctx context.Context, ID int) (domain.Track, error) {
    return t.TrackRepository.FindTrackByID(ctx, ID)
}

// FindTracksByName implements domain.TrackUseCase.
func (t TrackUseCase) FindTracksByName(ctx context.Context, name string) ([]domain.Track, error) {
    return t.TrackRepository.FindTracksByName(ctx, name)
}

// GetAllTracks implements domain.TrackUseCase.
func (t TrackUseCase) GetAllTracks(ctx context.Context) ([]domain.Track, error) {
    return t.TrackRepository.GetAllTracks(ctx)
}

// UpdateTrack implements domain.TrackUseCase.
func (t TrackUseCase) UpdateTrack(ctx context.Context, track domain.Track) (domain.Track, error) {
    existingTrack, err := t.TrackRepository.FindTrackByID(ctx, track.ID)
    if err != nil {
        return domain.Track{}, err
    }
    if existingTrack.ID == 0 {
        return domain.Track{}, errors.New("track not found")
    }

    return t.TrackRepository.UpdateTrack(ctx, track)
}

// NewTrackUseCase creates a new instance of TrackUseCase.
func NewTrackUseCase(TrackRepository domain.TrackRepository) domain.TrackUseCase {
    return &TrackUseCase{ // Return a pointer to TrackUseCase
        TrackRepository: TrackRepository,
    }
}