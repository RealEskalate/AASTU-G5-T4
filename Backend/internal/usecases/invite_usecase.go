package usecases

import (
	domain "A2SVHUB/internal/domain"
	"A2SVHUB/internal/dtos"
	"A2SVHUB/pkg/config"
	"A2SVHUB/pkg/utils"
	"context"
)


type InviteUseCase struct {
	inviteRepository domain.InviteRepository
	config config.Config
	tokenService *utils.TokenService
	emailService *utils.EmailService
}

func NewInviteUseCase(inviteRepository domain.InviteRepository, config config.Config, tokenService *utils.TokenService, emailService *utils.EmailService) *InviteUseCase {
	return &InviteUseCase{
		inviteRepository: inviteRepository,
		config: config,
		tokenService: tokenService,
		emailService: emailService,
	}
}


func (i *InviteUseCase) CreateInvite(invite dtos.CreateInviteDTO) (*dtos.InviteDTO, *domain.ErrorResponse) {
	user, err := i.inviteRepository.GetUserByEmail(invite.Email, context.TODO())
	if (err == nil && user != nil){
		return &dtos.InviteDTO{}, &domain.ErrorResponse{
			Message: "User already exists",
			Status:  409,
		}
	}

	newUser, err := i.inviteRepository.CreateUser(invite, context.TODO())

	if err != nil{
		return &dtos.InviteDTO{}, &domain.ErrorResponse{
			Message: err.Error(),
			Status:  500,
		}
	}

	token, err := i.tokenService.GenerateInviteAccessToken(newUser.ID, invite.RoleID)
	if err != nil {
		return &dtos.InviteDTO{}, &domain.ErrorResponse{
			Message: err.Error(),
			Status:  500,
		}
	}

	newInvite, err := i.inviteRepository.CreateInvite(domain.Invite{
		Key:       token,
		RoleID:    invite.RoleID,
		UserID:    newUser.ID,
		GroupID:   invite.GroupID,
		Used:      false,
	}, context.TODO())
	
	err = i.emailService.SendInviteEmail(invite.Email, token)
	if err != nil {
		return &dtos.InviteDTO{}, &domain.ErrorResponse{
			Message: err.Error(),
			Status:  500,
		}
	}

	if err != nil {
		return &dtos.InviteDTO{}, &domain.ErrorResponse{
			Message: err.Error(),
			Status:  500,
		}
	}

	return &dtos.InviteDTO{
		ID:        newInvite.ID,
		Key:       newInvite.Key,
		RoleID:    newInvite.RoleID,
		UserID:    newInvite.UserID,
		GroupID:   newInvite.GroupID,
		Used:      newInvite.Used,
		CreatedAt: newInvite.CreatedAt,
		UpdatedAt: newInvite.UpdatedAt,
	}, nil
}

func (i *InviteUseCase) CreateInvites(invites dtos.CreateBatchInviteDTO) ([]dtos.InviteDTO, *domain.ErrorResponse) {
	var invitedUsers []domain.Invite
	if len(invites.Emails) == 0 {
		return []dtos.InviteDTO{}, &domain.ErrorResponse{
			Message: "No emails provided",
			Status:  400,
		}
	}

	users, err := i.inviteRepository.CreateUsers(invites, context.TODO())
	if err != nil {
		return []dtos.InviteDTO{}, &domain.ErrorResponse{
			Message: err.Error(),
			Status:  500,
		}
	}

	for _, user := range users{
		token, err := i.tokenService.GenerateInviteAccessToken(user.ID, invites.RoleID)
		if err != nil {

			return []dtos.InviteDTO{}, &domain.ErrorResponse{
				Message: err.Error(),
				Status:  500,
			}
		}
		err = i.emailService.SendInviteEmail(user.Email, token)
		if err != nil {
			return []dtos.InviteDTO{}, &domain.ErrorResponse{
				Message: err.Error(),
				Status:  500,
			}
		}

		invite := domain.Invite{
			Key:       token,
			RoleID:    invites.RoleID,
			UserID:    user.ID,
			GroupID:   invites.GroupID,
			Used:      false,
		}

		invitedUsers = append(invitedUsers, invite)
	}
	newInvites, err := i.inviteRepository.CreateInvites(invitedUsers, context.TODO())
	if err != nil {
		return []dtos.InviteDTO{}, &domain.ErrorResponse{
			Message: err.Error(),
			Status:  500,
		}
	}

	var invitedUserDtos []dtos.InviteDTO

	for _, invite := range newInvites {
		invitedUserDtos = append(invitedUserDtos, dtos.InviteDTO{
			ID:        invite.ID,
			Key:       invite.Key,
			RoleID:    invite.RoleID,
			UserID:    invite.UserID,
			GroupID:   invite.GroupID,
			Used:      invite.Used,
			CreatedAt: invite.CreatedAt,
			UpdatedAt: invite.UpdatedAt,
		})
	}
	return invitedUserDtos, nil
}


func (i *InviteUseCase) AcceptInvite(token string) (*dtos.InvitedUserDTO, *domain.ErrorResponse) {
	invite, err := i.inviteRepository.GetInviteByKey(token, context.TODO())
	if err != nil {
		return &dtos.InvitedUserDTO{}, &domain.ErrorResponse{
			Message: err.Error(),
			Status:  500,
		}
	}
	if invite == nil {
		return &dtos.InvitedUserDTO{}, &domain.ErrorResponse{
			Message: "Invite not found",
			Status:  404,
		}
	}

	userId, err := i.tokenService.VerifyJWT(token)
	if err != nil {
		return &dtos.InvitedUserDTO{}, &domain.ErrorResponse{
			Message: err.Error(),
			Status:  401,
		}
	}
	user, err := i.inviteRepository.GetUserByID(userId, context.TODO())
	if err != nil {
		return &dtos.InvitedUserDTO{}, &domain.ErrorResponse{
			Message: err.Error(),
			Status:  500,
		}
	}
	if user == nil {
		return &dtos.InvitedUserDTO{}, &domain.ErrorResponse{
			Message: "User not found",
			Status:  404,
		}
	}
 
	err = i.inviteRepository.UpdateInviteStatus(invite.ID, context.TODO())
	if err != nil {
		return &dtos.InvitedUserDTO{}, &domain.ErrorResponse{
			Message: err.Error(),
			Status:  500,
		}
	}

	invitedUser := &dtos.InvitedUserDTO{
		ID:                     user.ID,
		RoleID:                 user.RoleID,
		Name:                   user.Name,
		CountryID:              user.CountryID,
		University:             user.University,
		Email:                  user.Email,
		Leetcode:               user.Leetcode,
		Codeforces:             user.Codeforces,
		Github:                 user.Github,
		Photo:                  user.Photo,
		PreferredLanguage:      user.PreferredLanguage,
		Hackerrank:             user.Hackerrank,
		GroupID:                user.GroupID,
		Phone:                  user.Phone,
		TelegramUsername:       user.TelegramUsername,
		TelegramUID:            user.TelegramUID,
		Linkedin:               user.Linkedin,
		StudentID:              user.StudentID,
		ShortBio:               user.ShortBio,
		Instagram:              user.Instagram,
		Birthday:               user.Birthday,
		CV:                     user.CV,
		JoinedDate:             user.JoinedDate,
		ExpectedGraduationDate: user.ExpectedGraduationDate,
		MentorName:             user.MentorName,
		TshirtColor:            user.TshirtColor,
		TshirtSize:             user.TshirtSize,
		Gender:                 user.Gender,
		CodeOfConduct:          user.CodeOfConduct,
		Password:               user.Password,
		CreatedAt:              user.CreatedAt,
		UpdatedAt:              user.UpdatedAt,
		Config:                 user.Config,
		Department:             user.Department,
		Inactive:               user.Inactive,
	}

	return invitedUser, nil
}


func (i *InviteUseCase) InviteExistingUser(invite dtos.InviteExistingUserDTO) (*dtos.InviteDTO, *domain.ErrorResponse) {
	user, err := i.inviteRepository.GetUserByID(invite.ID, context.TODO())
	if err != nil {
		return &dtos.InviteDTO{}, &domain.ErrorResponse{
			Message: err.Error(),
			Status:  500,
		}
	}

	if user == nil {
		return &dtos.InviteDTO{}, &domain.ErrorResponse{
			Message: "User not found",
			Status:  404,
		}
	}

	token, err := i.tokenService.GenerateInviteAccessToken(user.ID, invite.RoleID)

	if err != nil {
		return &dtos.InviteDTO{}, &domain.ErrorResponse{
			Message: err.Error(),
			Status:  500,
		}
	}
	newInvite, err := i.inviteRepository.CreateInvite(domain.Invite{
		Key:       token,
		RoleID:    invite.RoleID,
		UserID:    user.ID,
		GroupID:   invite.GroupID,
		Used:      false,
	}, context.TODO())
	if err != nil {
		return &dtos.InviteDTO{}, &domain.ErrorResponse{
			Message: err.Error(),
			Status:  500,
		}
	}

	err = i.emailService.SendInviteEmail(user.Email, token)
	if err != nil {
		return &dtos.InviteDTO{}, &domain.ErrorResponse{
			Message: err.Error(),
			Status:  500,
		}
	}

	return &dtos.InviteDTO{
		ID:        newInvite.ID,
		Key:       newInvite.Key,
		RoleID:    newInvite.RoleID,
		UserID:    newInvite.UserID,
		GroupID:   newInvite.GroupID,
		Used:      newInvite.Used,
		CreatedAt: newInvite.CreatedAt,
		UpdatedAt: newInvite.UpdatedAt,
	}, nil

}