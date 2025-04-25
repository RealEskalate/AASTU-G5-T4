package usecases

import (
	"A2SVHUB/internal/domain"
	"context"
	"errors"
)

type ProblemUseCase struct {
	ProblemRepository domain.ProblemRepository
}

// CreateProblem implements domain.ProblemUseCase.
func (p ProblemUseCase) CreateProblem(ctx context.Context, problem domain.Problem) (domain.Problem, error) {
	// Perform some business logic before creating the problem

	// TODO : make sure to check existence of this filed below
	// ContestID:  problem.ContestID,
	// TrackID:    problem.TrackID,

	if problem.Name == "" {
		return domain.Problem{}, errors.New("problem name cannot be empty")
	}
	if problem.Tag == "" {
		return domain.Problem{}, errors.New("problem must have at least 1 tag")
	}
	if problem.Difficulty != "easy" && problem.Difficulty != "medium" && problem.Difficulty != "hard" && problem.Difficulty != "none" {
		return domain.Problem{}, errors.New("invalid difficulty level")
	}
	if problem.Platform == "" {
		return domain.Problem{}, errors.New("platform cannot be empty")
	}
	if problem.Link == "" {
		return domain.Problem{}, errors.New("link cannot be empty")
	}

	// Call the repository to create the problem
	return p.ProblemRepository.CreateProblem(ctx, problem)
}

// DeleteProblem implements domain.ProblemUseCase.
func (p ProblemUseCase) DeleteProblem(ctx context.Context, id int) error {
	// Check if the problem exists
	if _, err := p.ProblemRepository.GetProblemByID(ctx, id); err != nil {
		return errors.New("problem not found")
	}

	// Call the repository to delete the problem
	return p.ProblemRepository.DeleteProblem(ctx, id)
}

// GetProblemByID implements domain.ProblemUseCase.
func (p ProblemUseCase) GetProblemByID(ctx context.Context, id int) (domain.Problem, error) {
	// Call the repository to fetch the problem by ID
	problem, err := p.ProblemRepository.GetProblemByID(ctx, id)
	if err != nil {
		return domain.Problem{}, errors.New("problem not found")
	}
	return problem, nil
}

// GetProblemByName implements domain.ProblemUseCase.
func (p ProblemUseCase) GetProblemByName(ctx context.Context, name string) ([]domain.Problem, error) {
	// Call the repository to fetch the problem by name
	problem, err := p.ProblemRepository.GetProblemByName(ctx, name)
	if err != nil {
		return []domain.Problem{}, errors.New("problem not found")
	}
	return problem, nil
}

// UpdateProblem implements domain.ProblemUseCase.
func (p ProblemUseCase) UpdateProblem(ctx context.Context, id int, problem domain.Problem) error {
	// Check if the problem exists
	existingProblem, err := p.ProblemRepository.GetProblemByID(ctx, id)
	if err != nil {
		return errors.New("problem not found")
	}

	// TODO : make sure to check existence of this filed below
	// ContestID:  problem.ContestID,
	// TrackID:    problem.TrackID,

	// Perform some business logic before updating the problem
	if problem.Name == "" {
		return errors.New("problem name cannot be empty")
	}
	if problem.Difficulty != "" && problem.Difficulty != "easy" && problem.Difficulty != "medium" && problem.Difficulty != "hard" && problem.Difficulty != "none" {
		return errors.New("invalid difficulty level")
	}
	if problem.Platform == "" {
		return errors.New("platform cannot be empty")
	}
	if problem.Link == "" {
		return errors.New("link cannot be empty")
	}

	// Merge the updates with the existing problem
	if problem.ContestID != nil {
		existingProblem.ContestID = problem.ContestID
	}
	if problem.TrackID != nil {
		existingProblem.TrackID = problem.TrackID
	}
	if problem.Name != "" {
		existingProblem.Name = problem.Name
	}
	if problem.Difficulty != "" {
		existingProblem.Difficulty = problem.Difficulty
	}
	if problem.Tag != "" {
		existingProblem.Tag = problem.Tag
	}
	if problem.Platform != "" {
		existingProblem.Platform = problem.Platform
	}
	if problem.Link != "" {
		existingProblem.Link = problem.Link
	}

	// Call the repository to update the problem
	return p.ProblemRepository.UpdateProblem(ctx, existingProblem)
}

// GetProblemsByNameAndFilters implements domain.ProblemUseCase.
func (p ProblemUseCase) GetProblemsByNameAndFilters(ctx context.Context, name string, filter map[string]interface{}) ([]domain.Problem, error) {
	// Call the repository to fetch problems by name and filters
	problems, err := p.ProblemRepository.GetProblemsByNameAndFilters(ctx, name, filter)
	if err != nil {
		return nil, err
	}
	return problems, nil
}

func NewProblemUseCase(ProblemRepository domain.ProblemRepository) domain.ProblemUseCase {
	return ProblemUseCase{
		ProblemRepository: ProblemRepository,
	}
}
