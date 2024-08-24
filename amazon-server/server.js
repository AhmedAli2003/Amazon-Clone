const app = require('./app');
const mongoose = require('mongoose');

mongoose.connect().then(() => {
    console.log('Database connection established successfully');
}).catch((e) => {
    console.log('Error while establishing connection with the database');
    console.log(e);
});

const PORT = 3000;
app.listen(PORT, '127.0.0.1', () => {
    console.log('Server listening on port ' + PORT);
});
