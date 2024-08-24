const app = require('./app');
const initDatabase = require('./db-init');

// Load environment variables
require('dotenv').config();

const databaseUrl = process.env.DATABASE_URL;

initDatabase(databaseUrl);

const port = process.env.PORT || 3000;
app.listen(port, '127.0.0.1', () => {
    console.log('Server listening on port ' + port);
});
