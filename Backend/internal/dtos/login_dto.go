package dtos

type LoginRequest struct {
	Email    string `json:"email" binding:"required,email"`
	Password string `json:"password" binding:"required,min=8,max=32"`
}

type LoginUserResponse struct {
	ID                int    `json:"id"`
	RoleID            int    `json:"role_id"`
	Name              string `json:"name"`
	CountryID         int    `json:"country_id"`
	University        string `json:"university"`
	Email             string `json:"email"`
	Leetcode          string `json:"leetcode,omitempty"`
	Codeforces        string `json:"codeforces,omitempty"`
	Github            string `json:"github,omitempty"`
	AvatarURL         string `json:"avatar_url"`
	PreferredLanguage string `json:"preferred_language,omitempty"`
	Hackerrank        string `json:"hackerrank,omitempty"`
	GroupID           int    `json:"group_id"`
	Phone             string `json:"phone,omitempty"`
	TelegramUsername  string `json:"telegram_username,omitempty"`
	TelegramUID       string `json:"telegram_uid,omitempty"`
	Linkedin          string `json:"linkedin,omitempty"`
	StudentID         string `json:"student_id,omitempty"`
	ShortBio          string `json:"short_bio,omitempty"`
	Instagram         string `json:"instagram,omitempty"`
	Birthday          string `json:"birthday"`
	Gender            string `json:"gender,omitempty"`
	Department        string `json:"department,omitempty"`
	Role              string `json:"role"`
	Country           string `json:"country"`
}

type LoginResponse struct {
	Token        string            `json:"token"`
	RefreshToken string            `json:"refresh_token"`
	User         LoginUserResponse `json:"user"`
}
