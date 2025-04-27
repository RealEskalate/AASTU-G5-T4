package repositories

import (
	"A2SVHUB/internal/domain"
	"encoding/json"
	"sync"
	"time"
)

type CacheRepository struct {
	store sync.Map
}

func NewCacheRepository() domain.CacheRepository {
	return &CacheRepository{}
}

func (r *CacheRepository) Set(key string, value interface{}, expiration time.Duration) error {
	data, err := json.Marshal(value)
	if err != nil {
		return err
	}
	r.store.Store(key, data)
	return nil
}

func (r *CacheRepository) Get(key string) (interface{}, error) {
	if value, ok := r.store.Load(key); ok {
		return value, nil
	}
	return nil, nil
}

func (r *CacheRepository) Delete(key string) error {
	r.store.Delete(key)
	return nil
}
