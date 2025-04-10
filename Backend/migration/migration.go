package migration

import (
	"A2SVHUB/internal/domain"

	"gorm.io/gorm"
)

func MigrateModels(db *gorm.DB) error {
	modelsToMigrate := []interface{}{
		&domain.User{},
		&domain.APIToken{},
		&domain.AssistantMessage{},
		&domain.RecentAction{},
		&domain.Notification{},
		&domain.OutsideConsistency{},
		&domain.Track{},
		&domain.Session{},
		&domain.Attendance{},
		&domain.Stipend{},
		&domain.AdonisSchema{},
		&domain.AdonisSchemaVersions{},
		&domain.RateLimit{},
		&domain.Cache{},
		&domain.DailyProblem{},
		&domain.Exercise{},
		&domain.Submission{},
		&domain.ProblemTrack{},
		&domain.Post{},
		&domain.PostTag{},
		&domain.PostToTag{},
		&domain.StudentMetrics{},
		&domain.ClassHeadMetrics{},
		&domain.AcademyLeadsMetrics{},
		&domain.Group{},
		&domain.HOA{},
		&domain.Invite{},
		&domain.GoogleOAuth{},
		&domain.GroupSession{},
		&domain.Contest{},
		&domain.Rating{},
		&domain.DivisionUser{},
		&domain.Problem{},
		&domain.Country{},
		&domain.Role{},
		&domain.Division{},
		&domain.File{},
		&domain.Fund{},
		&domain.Event{},
		&domain.Comment{},
		&domain.Vote{},
		&domain.SuperGroup{},
		&domain.SuperToGroup{},
	}

	for _, model := range modelsToMigrate {
		if err := db.AutoMigrate(model); err != nil {
			return err
		}
	}
	return nil
}
