package repositories

import (
	"A2SVHUB/internal/domain"
	"context"
	"net/http"
)

type ContestClient struct {
	client *http.Client
}

func NewContestClient() domain.ContestClient {
	return &ContestClient{
		client: &http.Client{},
	}
}

func (c *ContestClient) FetchContests(ctx context.Context) ([]*domain.Contest, error) {
	
	return nil, nil
}
