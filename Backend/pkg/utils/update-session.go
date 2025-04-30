package utils

import (
	"A2SVHUB/internal/domain"
	"A2SVHUB/internal/dtos"
	"time"
)

func UpdateSessionUtil(session *dtos.UpdateSessionDTOS,  existingSession *domain.Session)(*domain.Session){
	if session.Name != "" {
		existingSession.Name = session.Name
	}
	if session.Description != "" {
		existingSession.Description = session.Description
	}

	if session.StartTime != (time.Time{}) {
		existingSession.StartTime = session.StartTime
	}

	if session.EndTime != (time.Time{}) {
		existingSession.EndTime = session.EndTime
	}

	if session.MeetLink != "" {
		existingSession.MeetLink = session.MeetLink
	}
	if session.Location != "" {
		existingSession.Location = session.Location
	}
	if session.ResourceLink != "" {
		existingSession.ResourceLink = session.ResourceLink
	}

	if session.RecordingLink != "" {
		existingSession.RecordingLink = session.RecordingLink
	}

	if session.CalendarEventID != "" {
		existingSession.CalendarEventID = session.CalendarEventID
	}

	if session.LecturerID != 0 {
		existingSession.LecturerID = session.LecturerID
	}

	if session.FundID != nil {
		existingSession.FundID = session.FundID
	}

	existingSession.UpdatedAt = time.Now()

	return existingSession

}