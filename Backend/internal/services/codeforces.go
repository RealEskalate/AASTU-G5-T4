package services

import (
	"A2SVHUB/internal/domain"
	"encoding/json"
	"fmt"
	"io/ioutil"
	"net/http"
)

type ContestAPIResponse struct {
	Status string           `json:"status"`
	Result []domain.Contest `json:"result"`
}

func FetchContestsFromCodeforces() ([]domain.Contest, error) {
	resp, err := http.Get("https://codeforces.com/api/contest.list")
	if err != nil {
		return nil, fmt.Errorf("failed to fetch contests: %w", err)
	}
	defer resp.Body.Close()

	body, _ := ioutil.ReadAll(resp.Body)

	var apiResp ContestAPIResponse
	if err := json.Unmarshal(body, &apiResp); err != nil {
		return nil, fmt.Errorf("error unmarshaling contest response: %w", err)
	}

	if apiResp.Status != "OK" {
		return nil, fmt.Errorf("codeforces returned status: %s", apiResp.Status)
	}

	return apiResp.Result, nil
}
