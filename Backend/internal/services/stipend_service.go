package services

import (
	"A2SVHUB/internal/domain"
	"A2SVHUB/internal/dtos"
	"A2SVHUB/internal/repositories"
	"context"
	"time"
)

type StipendService interface {
	CreateStipend(ctx context.Context, req *dtos.CreateStipendRequest) (*dtos.StipendResponse, error)
	GetStipend(ctx context.Context, id int) (*dtos.StipendResponse, error)
	GetStipendsByUser(ctx context.Context, userID int) ([]*dtos.StipendResponse, error)
	GetStipendsBySession(ctx context.Context, sessionID int) ([]*dtos.StipendResponse, error)
	UpdateStipend(ctx context.Context, id int, req *dtos.UpdateStipendRequest) (*dtos.StipendResponse, error)
	DeleteStipend(ctx context.Context, id int) error
}

type stipendService struct {
	repo repositories.StipendRepository
}

func NewStipendService(repo repositories.StipendRepository) StipendService {
	return &stipendService{repo: repo}
}

func (s *stipendService) CreateStipend(ctx context.Context, req *dtos.CreateStipendRequest) (*dtos.StipendResponse, error) {
	stipend := &domain.Stipend{
		FundID:    req.FundID,
		UserID:    req.UserID,
		SessionID: req.SessionID,
		Share:     req.Share,
		Paid:      false,
	}

	if err := s.repo.Create(ctx, stipend); err != nil {
		return nil, err
	}

	return s.mapToResponse(stipend), nil
}

func (s *stipendService) GetStipend(ctx context.Context, id int) (*dtos.StipendResponse, error) {
	stipend, err := s.repo.GetByID(ctx, id)
	if err != nil {
		return nil, err
	}
	return s.mapToResponse(stipend), nil
}

func (s *stipendService) GetStipendsByUser(ctx context.Context, userID int) ([]*dtos.StipendResponse, error) {
	stipends, err := s.repo.GetByUserID(ctx, userID)
	if err != nil {
		return nil, err
	}
	return s.mapToResponseList(stipends), nil
}

func (s *stipendService) GetStipendsBySession(ctx context.Context, sessionID int) ([]*dtos.StipendResponse, error) {
	stipends, err := s.repo.GetBySessionID(ctx, sessionID)
	if err != nil {
		return nil, err
	}
	return s.mapToResponseList(stipends), nil
}

func (s *stipendService) UpdateStipend(ctx context.Context, id int, req *dtos.UpdateStipendRequest) (*dtos.StipendResponse, error) {
	stipend, err := s.repo.GetByID(ctx, id)
	if err != nil {
		return nil, err
	}

	stipend.Paid = req.Paid
	if err := s.repo.Update(ctx, stipend); err != nil {
		return nil, err
	}

	return s.mapToResponse(stipend), nil
}

func (s *stipendService) DeleteStipend(ctx context.Context, id int) error {
	return s.repo.Delete(ctx, id)
}

func (s *stipendService) mapToResponse(stipend *domain.Stipend) *dtos.StipendResponse {
	return &dtos.StipendResponse{
		ID:        stipend.ID,
		FundID:    stipend.FundID,
		UserID:    stipend.UserID,
		Paid:      stipend.Paid,
		SessionID: stipend.SessionID,
		Share:     stipend.Share,
		CreatedAt: stipend.CreatedAt.Format(time.RFC3339),
		UpdatedAt: stipend.UpdatedAt.Format(time.RFC3339),
	}
}

func (s *stipendService) mapToResponseList(stipends []*domain.Stipend) []*dtos.StipendResponse {
	responses := make([]*dtos.StipendResponse, len(stipends))
	for i, stipend := range stipends {
		responses[i] = s.mapToResponse(stipend)
	}
	return responses
}
