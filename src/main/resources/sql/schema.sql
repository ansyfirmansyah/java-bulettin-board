-- Tabel untuk menyimpan post bulletin board
CREATE TABLE posts
(
    id         SERIAL PRIMARY KEY,
    title      VARCHAR(100) NOT NULL,
    author     VARCHAR(10)  NOT NULL,
    password   VARCHAR(255) NOT NULL,
    content    TEXT         NOT NULL,
    view_count INTEGER   DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP,
    is_deleted BOOLEAN   DEFAULT FALSE
);

-- Index untuk mempercepat pencarian
CREATE INDEX idx_posts_is_deleted ON posts (is_deleted);