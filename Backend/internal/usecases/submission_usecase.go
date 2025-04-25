package usecases

import (
    "A2SVHUB/internal/domain"
    "context"
    "errors"
)

type SubmissionUseCase struct {
    SubmissionRepository domain.SubmissionRepository
}

// CreateSubmission creates a new submission.
func (uc *SubmissionUseCase) CreateSubmission(ctx context.Context, submission domain.Submission) (domain.Submission, error) {
    if submission.ProblemID == 0 {
        return domain.Submission{}, errors.New("problem ID cannot be zero")
    }
    if submission.UserID == 0 {
        return domain.Submission{}, errors.New("user ID cannot be zero")
    }
	// Temporarily bypass userID validation for testing
    // if submission.UserID == 0 {
    //     submission.UserID = -1 // Use a placeholder value for testing
    // }
    if submission.Code == "" {
        return domain.Submission{}, errors.New("submission code cannot be empty")
    }

    //Ensure the problem ID exists
    _, err := uc.SubmissionRepository.GetSubmissionsByProblem(ctx, submission.ProblemID)
    if err != nil {
        return domain.Submission{}, errors.New("invalid problem ID: problem does not exist")
    }

    return uc.SubmissionRepository.CreateSubmission(ctx, submission)
}

// GetSubmissionByID retrieves a submission by its ID.
func (uc *SubmissionUseCase) GetSubmissionByID(ctx context.Context, id int) (domain.Submission, error) {
    if id == 0 {
        return domain.Submission{}, errors.New("submission ID cannot be zero")
    }

    submission, err := uc.SubmissionRepository.GetSubmissionByID(ctx, id)
    if err != nil {
        if err.Error() == "submission not found" {
            return domain.Submission{}, errors.New("submission not found")
        }
        return domain.Submission{}, err
    }

    return submission, nil
}

// GetSubmissionsByProblem retrieves all submissions for a specific problem.
func (uc *SubmissionUseCase) GetSubmissionsByProblem(ctx context.Context, problemID int) ([]domain.Submission, error) {
    if problemID == 0 {
        return nil, errors.New("problem ID cannot be zero")
    }

    submissions, err := uc.SubmissionRepository.GetSubmissionsByProblem(ctx, problemID)
    if err != nil {
        if err.Error() == "no submissions found for the given problem" {
            return nil, errors.New("no submissions found for the given problem")
        }
        return nil, err
    }

    return submissions, nil
}

// UpdateSubmission updates an existing submission.
func (uc *SubmissionUseCase) UpdateSubmission(ctx context.Context, submission domain.Submission) (domain.Submission, error) {
    if submission.ID == 0 {
        return domain.Submission{}, errors.New("submission ID cannot be zero")
    }
    if submission.Code == "" {
        return domain.Submission{}, errors.New("submission code cannot be empty")
    }

    //Ensure the submission exists
    _, err := uc.SubmissionRepository.GetSubmissionByID(ctx, submission.ID)
    if err != nil {
        if err.Error() == "submission not found" {
            return domain.Submission{}, errors.New("submission not found")
        }
        return domain.Submission{}, err
    }

    return uc.SubmissionRepository.UpdateSubmission(ctx, submission)
}

// DeleteSubmission deletes a submission by its ID.
func (uc *SubmissionUseCase) DeleteSubmission(ctx context.Context, id int) error {
    if id == 0 {
        return errors.New("submission ID cannot be zero")
    }

    //  Ensure the submission exists
    _, err := uc.SubmissionRepository.GetSubmissionByID(ctx, id)
    if err != nil {
        if err.Error() == "submission not found" {
            return errors.New("submission not found")
        }
        return err
    }

    return uc.SubmissionRepository.DeleteSubmission(ctx, id)
}

// NewSubmissionUseCase creates a new instance of SubmissionUseCase.
func NewSubmissionUseCase(repo domain.SubmissionRepository) domain.SubmissionUseCase {
    return &SubmissionUseCase{SubmissionRepository: repo}
}