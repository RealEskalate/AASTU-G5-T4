package middleware

import (
	"A2SVHUB/pkg/utils"
	"net/http"
	"strings"

	"github.com/gin-gonic/gin"
	"github.com/golang-jwt/jwt/v5"
)

// AuthMiddleware returns a middleware that validates JWTs and extracts user info.
func AuthMiddleware(tokenService *utils.TokenService, allowedRoles ...int) gin.HandlerFunc {
	return func(c *gin.Context) {
		authHeader := c.GetHeader("Authorization")
		if authHeader == "" || !strings.HasPrefix(authHeader, "Bearer ") {
			c.AbortWithStatusJSON(http.StatusUnauthorized, gin.H{"error": "Missing or malformed Authorization header"})
			return
		}

		tokenString := strings.TrimPrefix(authHeader, "Bearer ")

		// Parse token manually to access claims
		token, err := tokenService.VerifyTokenRaw(tokenString)
		if err != nil {
			c.AbortWithStatusJSON(http.StatusUnauthorized, gin.H{"error": "Invalid or expired token"})
			return
		}

		claims, ok := token.Claims.(jwt.MapClaims)
		if !ok {
			c.AbortWithStatusJSON(http.StatusUnauthorized, gin.H{"error": "Invalid token claims"})
			return
		}

		userID, ok := claims["sub"].(float64)
		if !ok {
			c.AbortWithStatusJSON(http.StatusUnauthorized, gin.H{"error": "Missing user ID in token"})
			return
		}

		roleID, ok := claims["role_id"].(float64)
		if !ok {
			c.AbortWithStatusJSON(http.StatusUnauthorized, gin.H{"error": "Missing role ID in token"})
			return
		}

		// Optional role check
		if len(allowedRoles) > 0 {
			valid := false
			for _, r := range allowedRoles {
				if r == int(roleID) {
					valid = true
					break
				}
			}
			if !valid {
				c.AbortWithStatusJSON(http.StatusForbidden, gin.H{"error": "Insufficient role permissions"})
				return
			}
		}

		// Store user data in context
		c.Set("user_id", int(userID))
		c.Set("role_id", int(roleID))

		c.Next()
	}
}
