package domain

type StudentMetrics struct {
	ID                  int     `gorm:"primaryKey"`
	UserID              int     `gorm:"type:integer"`
	NumberOfSolutions   int     `gorm:"type:integer"`
	TimeSpent           float64 `gorm:"type:float"` // in hours
	Rating              float64 `gorm:"type:float"`
	ProblemSolvingGraph string  `gorm:"type:text"` // URL or serialized data
	DailySolvedProblems int     `gorm:"type:integer"`
	LastSubmissions     string  `gorm:"type:text"` // Serialized list of submission IDs or descriptions
	User                User    `gorm:"foreignKey:UserID"`
}

type ClassHeadMetrics struct {
	ID                       int     `gorm:"primaryKey"`
	UserID                   int     `gorm:"type:integer"`
	TotalClassSolutions      int     `gorm:"type:integer"`
	TotalClassTimeSpent      float64 `gorm:"type:float"` // in hours
	AverageClassRating       float64 `gorm:"type:float"`
	ClassProblemSolvingGraph string  `gorm:"type:text"` // URL or serialized data
	DailySolveCount          int     `gorm:"type:integer"`
	LastClassSubmissions     string  `gorm:"type:text"` // Serialized list of submission IDs or descriptions
	User                     User    `gorm:"foreignKey:UserID"`
}

type AcademyLeadsMetrics struct {
	ID                        int     `gorm:"primaryKey"`
	UserID                    int     `gorm:"type:integer"`
	TotalSchoolSolutions      int     `gorm:"type:integer"`
	TotalSchoolTimeSpent      float64 `gorm:"type:float"` // in hours
	AcademyWideAverageRating  float64 `gorm:"type:float"`
	SchoolProblemSolvingGraph string  `gorm:"type:text"` // URL or serialized data
	User                      User    `gorm:"foreignKey:UserID"`
}
