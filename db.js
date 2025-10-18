// db.js
const { Pool } = require('pg');

const pool = new Pool({
  connectionString: process.env.DATABASE_URL || 'postgres://postgres:zxc@localhost:5432/memorial_db',
  // или отдельные env: PGHOST, PGUSER, PGPASSWORD, PGDATABASE, PGPORT
});

module.exports = {
  query: (text, params) => pool.query(text, params),
  pool
};
