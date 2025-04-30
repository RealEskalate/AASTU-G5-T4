package services

import (
	"A2SVHUB/internal/domain"
	"encoding/json"
	"fmt"
	"io/ioutil"
	"math"
	"net/http"
	"time"
)

const (
	baseURL  = "https://codeforces.com/api"
	kFactor  = 40
	startElo = 1400
)

type StandingsResponse struct {
	Result struct {
		Rows []struct {
			Party struct {
				Members []struct {
					Handle string `json:"handle"`
				} `json:"members"`
			} `json:"party"`
			ProblemResults []struct {
				Points float64 `json:"points"`
			} `json:"problemResults"`
		} `json:"rows"`
	} `json:"result"`
}

func calculateElo(currentRating, opponentRating float64, score float64) float64 {
	expectedScore := 1 / (1 + math.Pow(10, (opponentRating-currentRating)/400))
	newRating := currentRating + kFactor*(score-expectedScore)
	return newRating
}

func FetchRankingsForContest(contestId int) ([]domain.Rating, error) {
	url := fmt.Sprintf("%s/contest.standings?contestId=%d&from=1&count=10000&showUnofficial=true", baseURL, contestId)

	resp, err := http.Get(url)
	if err != nil {
		return nil, err
	}
	defer resp.Body.Close()

	body, _ := ioutil.ReadAll(resp.Body)
	var data StandingsResponse
	if err := json.Unmarshal(body, &data); err != nil {
		return nil, err
	}

	var ratings []domain.Rating
	for idx, row := range data.Result.Rows {
		solved := 0
		for _, p := range row.ProblemResults {
			if p.Points > 0.0 {
				solved++
			}
		}

		newRating := calculateElo(startElo, startElo, 1)

		ratings = append(ratings, domain.Rating{
			ContestID: contestId,
			UserID:    idx + 1, 
			Rank:      idx + 1,
			Solved:    solved,
			Gain:      int(newRating) - startElo, 
			Points:    int(newRating),            
			CreatedAt: time.Now(),
			UpdatedAt: time.Now(),
		})
	}

	return ratings, nil
}
