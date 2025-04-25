package repositories

import (
    "A2SVHUB/internal/domain"
    "context"
    "errors"
    "gorm.io/gorm"
)

type SubmissionRepository struct {
    db *gorm.DB
}

// CreateSubmission creates a new submission in the database.
func (r *SubmissionRepository) CreateSubmission(ctx context.Context, submission domain.Submission) (domain.Submission, error) {
    if err := r.db.WithContext(ctx).Create(&submission).Error; err != nil {
        return domain.Submission{}, err
    }
    return submission, nil
}

// GetSubmissionByID retrieves a submission by its ID.
func (r *SubmissionRepository) GetSubmissionByID(ctx context.Context, id int) (domain.Submission, error) {
    var submission domain.Submission
    if err := r.db.WithContext(ctx).First(&submission, id).Error; err != nil {
        if errors.Is(err, gorm.ErrRecordNotFound) {
            return domain.Submission{}, errors.New("submission not found")
        }
        return domain.Submission{}, err
    }
    return submission, nil
}

// GetSubmissionsByProblem retrieves all submissions for a specific problem.
func (r *SubmissionRepository) GetSubmissionsByProblem(ctx context.Context, problemID int) ([]domain.Submission, error) {
    var submissions []domain.Submission
    if err := r.db.WithContext(ctx).Where("problem_id = ?", problemID).Find(&submissions).Error; err != nil {
        return nil, err
    }
    if len(submissions) == 0 {
        return nil, errors.New("no submissions found for the given problem")
    }
    return submissions, nil
}

// UpdateSubmission updates an existing submission.
func (r *SubmissionRepository) UpdateSubmission(ctx context.Context, submission domain.Submission) (domain.Submission, error) {
    var existingSubmission domain.Submission
    if err := r.db.WithContext(ctx).First(&existingSubmission, submission.ID).Error; err != nil {
        if errors.Is(err, gorm.ErrRecordNotFound) {
            return domain.Submission{}, errors.New("submission not found")
        }
        return domain.Submission{}, err
    }

    if err := r.db.WithContext(ctx).Save(&submission).Error; err != nil {
        return domain.Submission{}, err
    }
    return submission, nil
}

// DeleteSubmission deletes a submission by its ID.
func (r *SubmissionRepository) DeleteSubmission(ctx context.Context, id int) error {
    var submission domain.Submission
    if err := r.db.WithContext(ctx).First(&submission, id).Error; err != nil {
        if errors.Is(err, gorm.ErrRecordNotFound) {
            return errors.New("submission not found")
        }
        return err
    }

    if err := r.db.WithContext(ctx).Delete(&submission).Error; err != nil {
        return err
    }
    return nil
}

// NewSubmissionRepository creates a new instance of SubmissionRepository.
func NewSubmissionRepository(db *gorm.DB) domain.SubmissionRepository {
    return &SubmissionRepository{db: db}
}