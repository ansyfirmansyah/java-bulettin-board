# Bulletin Board

## Project Structure
- **Backend**: Spring MVC REST API untuk operasi terkait data (CRUD)
- **Frontend**: JSP pages dengan JavaScript client yang consume REST API

## Technology Stack

### Backend
- Java 21
- Spring MVC 6
- MyBatis 3
- PostgreSQL Database
- HikariCP untuk connection pooling

### Frontend
- JSP (Java Server Pages)
- Bootstrap 5 CSS Framework
- JavaScript (dengan Fetch API)
- jQuery untuk DOM manipulation dan form validation

## Features

1. **Post Management**
    - List semua posts
    - View post details
    - Create posts baru
    - Edit posts yang ada
    - Delete posts (dengan soft delete)

2. **Authentication**
    - Wajib mengisi Password untuk edit dan delete posts
    - Tiap post memiliki password-nya

3. **Formatting**
    - Title max 100 char
    - Author max 10 char

## API Endpoints

### Posts

- **GET /api/posts** - Get all posts
- **GET /api/posts/{id}** - Get a specific post
- **POST /api/posts** - Create a new post
- **PUT /api/posts/{id}** - Update an existing post
- **DELETE /api/posts/{id}** - Delete a post
- **POST /api/posts/{id}/verify-password** - Verify post password

## Setup and Installation

### Prerequisites
- Java 21
- Maven
- PostgreSQL

### Database Setup
1. Buat database PostgreSQL dengan nama `bulletin_board`
2. Update `database.properties` sesuai PostgreSQL credentials
3. Jalankan SQL scripts yang ada di folder `resources/sql`:
    - `schema.sql` untuk membuat table dan function yang diperlukan
    - `data.sql` untuk menambahkan sample data

### Docker Setup
## Create docker network
docker network create bulletin-network

## Run PostgreSQL
docker run --name bulletin-postgres --network bulletin-network -e POSTGRES_PASSWORD=password -e POSTGRES_USER=postgres -e POSTGRES_DB=bulletin_board -v /path/to/local/folder:/var/lib/postgresql/data -p 5432:5432 -d postgres:latest

## Run Tomcat
docker run -d --name bulletin-tomcat -p 8080:8080 --network bulletin-network -v /path/to/local/folder:/usr/local/tomcat/webapps tomcat:10-jdk21
