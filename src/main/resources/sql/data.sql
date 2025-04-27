-- Clear existing data
TRUNCATE TABLE posts RESTART IDENTITY CASCADE;

-- Insert sample data
INSERT INTO posts (title, author, password, content, view_count, created_at)
VALUES
    ('Selamat datang di Bulletin Board', 'Admin', 'password123', 'Ini adalah konten dari bulletin board. Silahkan klik Create untuk menambah post!', 15, CURRENT_TIMESTAMP - INTERVAL '3 days'),

    ('저는 한국어 공부를 좋아합니다', 'JavaDev', 'java2023', '어제 저녁에 맛있는 한국 음식을 먹었어요', 19, CURRENT_TIMESTAMP - INTERVAL '6 hours');