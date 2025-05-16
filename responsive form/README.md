# User Registration Form with Monthly Statistics

This application provides a responsive registration form that stores user data in a PostgreSQL database and tracks monthly registration counts.

## Setup Instructions

### Prerequisites
- Node.js installed
- PostgreSQL database server running
- npm (Node Package Manager)

### Database Configuration
1. Make sure your PostgreSQL server is running
2. Update the database connection details in `server.js`:
   ```javascript
   const pool = new Pool({
       user: 'your_postgres_user',
       host: 'localhost',
       database: 'your_database_name',
       password: 'your_postgres_password',
       port: 5432,
   });
   ```

### Installation
1. Install dependencies:
   ```
   npm install
   ```

2. Start the server:
   ```
   npm start
   ```

3. Access the application at http://localhost:3000

## Features
- Responsive registration form
- Secure password storage with bcrypt
- Automatic tracking of monthly user registrations
- API endpoint to retrieve monthly statistics

## API Endpoints
- `POST /register` - Register a new user
- `GET /api/monthly-registrations` - Get monthly registration statistics

## Database Schema
The application creates the following database objects:

### Users Table
```sql
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)
```

### Monthly Registrations View
```sql
CREATE OR REPLACE VIEW monthly_registrations AS
SELECT 
    EXTRACT(YEAR FROM created_at) AS year,
    EXTRACT(MONTH FROM created_at) AS month,
    COUNT(*) AS user_count
FROM users
GROUP BY year, month
ORDER BY year, month
```

## Querying Monthly Registration Data
To get the monthly registration counts directly from PostgreSQL, run:

```sql
SELECT * FROM monthly_registrations;
```

This will return data in the format:
```
 year | month | user_count
------+-------+-----------
 2023 |     1 |        12
 2023 |     2 |        15
 ...
```