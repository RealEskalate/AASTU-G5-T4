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
func (t TrackUseCase) CreateTrack(ctx context.Context, name string, superGroupID int) (domain.Track, error) {
    return t.TrackRepository.CreateTrack(ctx, name, superGroupID)
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
func (t TrackUseCase) UpdateTrack(ctx context.Context, name string, ID int) (domain.Track, error) {
    track, err := t.TrackRepository.FindTrackByID(ctx, ID)
    if err != nil {
        return domain.Track{}, err
    }
    if track.ID == 0 {
        return domain.Track{}, errors.New("track not found")
    }
    return t.TrackRepository.UpdateTrack(ctx, name, ID)
}

func NewTrackUseCase(TrackRepository domain.TrackRepository) domain.TrackUseCase {
    return TrackUseCase{
        TrackRepository: TrackRepository,
    }
}