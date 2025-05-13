-- +migrate Up
CREATE TABLE IF NOT EXISTS stipends (
    id SERIAL PRIMARY KEY,
    fund_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    paid BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    session_id INTEGER NOT NULL,
    share REAL NOT NULL,
    FOREIGN KEY (fund_id) REFERENCES funds(id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (session_id) REFERENCES sessions(id)
); 