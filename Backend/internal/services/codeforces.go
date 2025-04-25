package services

import (
	"A2SVHUB/internal/domain"
	"crypto/sha512"
	"encoding/hex"
	"encoding/json"
	"fmt"
	"io"
	"math/rand"
	"net/http"
	"net/url"
	"os"
	"sort"
	"time"
)

type ContestAPIResponse struct {
	Status string           `json:"status"`
	Result []domain.Contest `json:"result"`
}

func generateSignature(method string, params map[string]string) string {
	rand.Seed(time.Now().UnixNano())
	randNum := fmt.Sprintf("%06d", rand.Intn(1000000))
	params["apiKey"] = os.Getenv("CODEFORCES_API_KEY")
	params["time"] = fmt.Sprintf("%d", time.Now().Unix())

	var keys []string
	for k := range params {
		keys = append(keys, k)
	}
	sort.Strings(keys)

	query := method + "?"
	for i, k := range keys {
		if i > 0 {
			query += "&"
		}
		query += fmt.Sprintf("%s=%s", k, url.QueryEscape(params[k]))
	}
	query += "#" + os.Getenv("CODEFORCES_API_SECRET")

	hash := sha512.Sum512([]byte(randNum + "/" + query))
	return randNum + hex.EncodeToString(hash[:])
}

func FetchContestsFromCodeforces() ([]domain.Contest, error) {
	params := map[string]string{
		"gym": "false",
	}
	signature := generateSignature("contest.list", params)
	params["apiSig"] = signature

	baseURL := "https://codeforces.com/api/contest.list"
	reqURL, _ := url.Parse(baseURL)
	query := reqURL.Query()
	for k, v := range params {
		query.Set(k, v)
	}
	reqURL.RawQuery = query.Encode()

	resp, err := http.Get(reqURL.String())
	if err != nil {
		return nil, fmt.Errorf("failed to fetch contests: %w", err)
	}
	defer resp.Body.Close()

	body, err := io.ReadAll(resp.Body)
	if err != nil {
		return nil, fmt.Errorf("error reading contest response body: %w", err)
	}

	var apiResp ContestAPIResponse
	if err := json.Unmarshal(body, &apiResp); err != nil {
		return nil, fmt.Errorf("error unmarshaling contest response: %w", err)
	}

	if apiResp.Status != "OK" {
		return nil, fmt.Errorf("codeforces returned status: %s", apiResp.Status)
	}

	return apiResp.Result, nil
}
