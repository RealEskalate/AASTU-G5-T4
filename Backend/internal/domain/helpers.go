
package domain

func ToUserResponse(u User) UserResponse {
	return UserResponse{
		ID:                u.ID,
		Name:              u.Name,
		Email:             u.Email,
		University:        u.University,
		AvatarURL:         u.AvatarURL,
		PreferredLanguage: u.PreferredLanguage,
		RoleID:            u.RoleID,
		CountryID:         u.CountryID,
		GroupID:           u.GroupID,
	}
}

func ToUserResponseList(users []User) []UserResponse {
	var response []UserResponse
	for _, u := range users {
		response = append(response, ToUserResponse(u))
	}
	return response
}
