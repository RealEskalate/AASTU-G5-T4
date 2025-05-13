package dtos

type CreateStipendRequest struct {
	FundID    int     `json:"fund_id" binding:"required"`
	UserID    int     `json:"user_id" binding:"required"`
	SessionID int     `json:"session_id" binding:"required"`
	Share     float32 `json:"share" binding:"required"`
}

type UpdateStipendRequest struct {
	Paid bool `json:"paid" binding:"required"`
}

type StipendResponse struct {
	ID        int     `json:"id"`
	FundID    int     `json:"fund_id"`
	UserID    int     `json:"user_id"`
	Paid      bool    `json:"paid"`
	SessionID int     `json:"session_id"`
	Share     float32 `json:"share"`
	CreatedAt string  `json:"created_at"`
	UpdatedAt string  `json:"updated_at"`
}
