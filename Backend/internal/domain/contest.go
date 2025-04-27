package domain

import (
	"context"
	"time"
)

type Contest struct {
	ID           int                `gorm:"primaryKey"`
	Name         string             `gorm:"type:varchar(255)"`
	Link         string             `gorm:"type:varchar(255)"`
	ProblemCount int                `gorm:"type:integer"`
	CreatedAt    time.Time          `gorm:"type:timestamp"`
	UpdatedAt    time.Time          `gorm:"type:timestamp"`
	Unrated      bool               `gorm:"default:false"`
	SuperGroupID int                `gorm:"type:integer"`
	Type         string             `gorm:"type:varchar(255)"`
	Link2        string             `gorm:"type:varchar(255)"`
	Link3        string             `gorm:"type:varchar(255)"`
	SuperGroup   SuperGroup         `gorm:"foreignKey:SuperGroupID"`
	Rating       int                `gorm:"type:integer"`
	Ratings      []Rating           `gorm:"foreignKey:ContestID"`
	Standings    *StandingsResponse `gorm:"-"`
	Problems     []struct {
		ContestID int      `json:"contestId"`
		Index     string   `json:"index"`
		Name      string   `json:"name"`
		Type      string   `json:"type"`
		Rating    int      `json:"rating"`
		Tags      []string `json:"tags"`
	} `gorm:"-"`
}

type Submissions struct {
	ID          int `gorm:"primaryKey"`
	UserID      int
	ProblemID   int
	IsSolved    bool
	SubmittedAt time.Time
	Penalty     int
}

type RatingResponse struct {
	Rating   Rating `json:"rating"`
	Title    string `json:"title"`
	Division int    `json:"division"`
}
type Rating struct {
	ID        int       `gorm:"primaryKey"`
	ContestID int       `gorm:"type:integer"`
	UserID    int       `gorm:"type:integer"`
	Rank      int       `gorm:"type:integer"`
	Penalty   int       `gorm:"type:integer"`
	Solved    int       `gorm:"type:integer"`
	Gain      int       `gorm:"type:integer"`
	CreatedAt time.Time `gorm:"type:timestamp"`
	UpdatedAt time.Time `gorm:"type:timestamp"`
	Points    int       `gorm:"type:integer"`
	FromPrev  int       `gorm:"default:0"`
	Contest   Contest   `gorm:"foreignKey:ContestID"`
	User      User      `gorm:"foreignKey:UserID"`
}

type DivisionUser struct {
	ID         int       `gorm:"primaryKey"`
	UserID     int       `gorm:"type:integer"`
	DivisionID int       `gorm:"type:integer"`
	ContestID  int       `gorm:"type:integer"`
	Active     bool      `gorm:"default:false"`
	CreatedAt  time.Time `gorm:"type:timestamp"`
	UpdatedAt  time.Time `gorm:"type:timestamp"`
	User       User      `gorm:"foreignKey:UserID"`
	Division   Division  `gorm:"foreignKey:DivisionID"`
	Contest    Contest   `gorm:"foreignKey:ContestID"`
}

type UserRanking struct {
	UserID    int       `json:"user_id"`
	UserName  string    `json:"user_name"`
	Points    int       `json:"points"`
	Rank      int       `json:"rank"`
	Solved    int       `json:"solved"`
	Penalty   int       `json:"penalty"`
	CreatedAt time.Time `json:"created_at"`
	UpdatedAt time.Time `json:"updated_at"`
}

type StandingsResponse struct {
	Status string `json:"status"`
	Result struct {
		Contest struct {
			ID   int    `json:"id"`
			Name string `json:"name"`
			Type string `json:"type"`
		} `json:"contest"`
		Problems []struct {
			Index string   `json:"index"`
			Name  string   `json:"name"`
			Tags  []string `json:"tags"`
		} `json:"problems"`
		Rows []struct {
			Party struct {
				Members []struct {
					Handle string `json:"handle"`
					ID     int    `json:"id"`
				} `json:"members"`
			} `json:"party"`
			Rank           int     `json:"rank"`
			Points         float64 `json:"points"`
			Penalty        int     `json:"penalty"`
			ProblemResults []struct {
				Points                    float64 `json:"points"`
				RejectedAttemptCount      int     `json:"rejectedAttemptCount"`
				Type                      string  `json:"type"`
				BestSubmissionTimeSeconds int     `json:"bestSubmissionTimeSeconds"`
			} `json:"problemResults"`
		} `json:"rows"`
	} `json:"result"`
}

type ContestStanding struct {
	ID        int       `gorm:"primaryKey"`
	ContestID int       `gorm:"type:integer"`
	Data      string    `gorm:"type:text"` // JSON string of StandingsResponse
	CreatedAt time.Time `gorm:"type:timestamp"`
	UpdatedAt time.Time `gorm:"type:timestamp"`
	Contest   Contest   `gorm:"foreignKey:ContestID"`
}

type ContestRepository interface {
	GetAllContests(ctx context.Context) ([]Contest, error)
	GetContestByID(ctx context.Context, id int) (Contest, error)
	SaveContest(ctx context.Context, contest *Contest) error
	GetStandings(ctx context.Context, contestID int) (*StandingsResponse, error)
	SaveStandings(ctx context.Context, contestID int, standings *StandingsResponse) error
	GetAllRatings(ctx context.Context, contestID int) ([]Rating, error)
	UpdateRating(ctx context.Context, contestID, userID, newRating int) error
}

type ContestUseCase interface {
	GetAllContests(ctx context.Context) ([]*Contest, error)
	GetContestByID(ctx context.Context, id int) (*Contest, error)
	AddContest(ctx context.Context, contest *Contest) error
	GetStandings(ctx context.Context, contestID int) (*StandingsResponse, error)
	SaveStandings(ctx context.Context, contestID int, standings *StandingsResponse) error
	ClearStandingsCache(ctx context.Context, contestID int) error
}

type RatingRepository interface {
	GetAllRatings(ctx context.Context, contestID int) ([]Rating, error)
	GetRatingByID(ctx context.Context, id int) (Rating, error)
	CalculateAndSaveRatings(ctx context.Context, contestID int) error
}

type RatingUseCase interface {
	GetAllRatings(ctx context.Context, contestID int) ([]Rating, error)
	GetRatingByID(ctx context.Context, id int) (*Rating, error)
	GenerateRatings(ctx context.Context, contestID int) error
}

type ContestClient interface {
	FetchContests(ctx context.Context) ([]*Contest, error)
}
