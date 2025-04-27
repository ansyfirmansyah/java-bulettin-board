DROP TABLE IF EXISTS posts;

CREATE TABLE posts
(
    id         SERIAL PRIMARY KEY,
    title      VARCHAR(100) NOT NULL CHECK (LENGTH(title) <= 100),
    author     VARCHAR(10)  NOT NULL CHECK (LENGTH(author) <= 10),
    password   VARCHAR(255) NOT NULL,
    content    TEXT         NOT NULL,
    view_count INTEGER      DEFAULT 0,
    created_at TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP    NULL,
    is_deleted BOOLEAN      DEFAULT FALSE
);

CREATE INDEX idx_posts_is_deleted ON posts (is_deleted);

CREATE OR REPLACE FUNCTION update_timestamp()
RETURNS TRIGGER AS $$
BEGIN
   NEW.updated_at = CURRENT_TIMESTAMP;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_posts_timestamp
    BEFORE UPDATE ON posts
    FOR EACH ROW
    WHEN (OLD.* IS DISTINCT FROM NEW.*)
EXECUTE FUNCTION update_timestamp();