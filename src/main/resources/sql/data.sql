-- Data awal untuk testing
INSERT INTO posts (title, author, password, content, view_count, created_at)
VALUES ('Selamat Datang di Bulletin Board', 'Admin', 'password123', 'Ini adalah post pertama di bulletin board ini.', 5,
        CURRENT_TIMESTAMP - INTERVAL '2 days'),
       ('Tutorial Spring MVC', 'User1', 'pass1234', 'Spring MVC adalah framework yang bagus untuk pengembangan web.', 3,
        CURRENT_TIMESTAMP - INTERVAL '1 day'),
       ('Pengumuman Penting', 'Admin', 'password123', 'Harap perhatikan pengumuman ini dengan seksama.', 10,
        CURRENT_TIMESTAMP - INTERVAL '12 hours');