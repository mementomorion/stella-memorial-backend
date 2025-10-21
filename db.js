require('dotenv').config(); // читаем .env

const { Pool } = require('pg');

const pool = new Pool({
  connectionString: process.env.DATABASE_URL, // если используешь DATABASE_URL
  host: process.env.PGHOST,
  user: process.env.PGUSER,
  password: process.env.PGPASSWORD,
  database: process.env.PGDATABASE,
  port: process.env.PGPORT,
});

module.exports = {
  query: (text, params) => pool.query(text, params),
  pool
};
