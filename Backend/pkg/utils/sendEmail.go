package utils

import (
	"A2SVHUB/pkg/config"
	"fmt"

	"gopkg.in/gomail.v2"
)

type EmailService struct {
	config config.Config
}

func NewEmailService(config config.Config) *EmailService {
    return &EmailService{
        config: config,
    }
}

func (e *EmailService)SendInviteEmail(to, token string) error {
	verificationLink := fmt.Sprintf("%s/invites/%s", e.config.API_URL, token)
	body := fmt.Sprintf(`
        <html>
        <head>
            <style>
                body { font-family: Arial, sans-serif; color: #333; line-height: 1.6; }
                .container { max-width: 600px; margin: 0 auto; padding: 20px; }
                .header { font-size: 24px; font-weight: bold; color: #1a73e8; }
                .button { display: inline-block; padding: 12px 24px; background-color: #1a73e8; color: #fff; text-decoration: none; border-radius: 5px; font-weight: bold; }
                .button:hover { background-color: #1557b0; }
                .link { word-break: break-all; color: #1a73e8; }
                .tagline { font-style: italic; color: #555; margin-top: 20px; }
            </style>
        </head>
        <body>
            <div class="container">
                <div class="header">A2SV Hub: Invitation</div>
                <p>Hello,</p>
                <p>We are absolutely thrilled to extend this special invitation to you, welcoming you to join the <strong>A2SV Hub</strong>—an exciting new frontier in education! Your presence will truly enrich our community and contribute to our collective pursuit of knowledge and growth.</p>
                <p>To get started, simply follow the link below to set up your account and unlock a world of endless learning possibilities:</p>
                <p><a href="%s" class="button">Accept Invitation</a></p>
                <p>Invitation Link: <a href="%s" class="link">%s</a></p>
                <p class="tagline">Enriching Minds, Enabling Dreams!</p>
            </div>
        </body>
        </html>
    `, verificationLink, verificationLink, verificationLink)

	m := gomail.NewMessage()
	m.SetHeader("From", fmt.Sprintf("%s <%s>", "A2SV Hub", e.config.EMAIL_FROM))
	m.SetHeader("To", to)
	m.SetHeader("Subject", "A2SV Hub: Invitation")
	m.SetBody("text/html", body)

	d := gomail.NewDialer(e.config.SMTP_HOST, e.config.SMTP_PORT, e.config.EMAIL_FROM, e.config.EMAIL_PASSWORD)

	if err := d.DialAndSend(m); err != nil {
		return fmt.Errorf("failed to send email: %v", err)
	}

	return nil
}