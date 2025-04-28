package domain

import "time"

// CacheRepository defines the interface for caching operations
type CacheRepository interface {
	// Set stores a value in the cache with a given key and expiration time
	Set(key string, value interface{}, expiration time.Duration) error

	// Get retrieves a value from the cache by key
	Get(key string) (interface{}, error)

	// Delete removes a value from the cache by key
	Delete(key string) error
}
