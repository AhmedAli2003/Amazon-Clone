const mongoose = require('mongoose');

async function initDatabase(url) {
    try {
        await mongoose.connect(url);
        console.log('Database connection established successfully');
    } catch (e) {
        console.log('Error while establishing connection with the database');
        console.log(e);
    }
}

module.exports = initDatabase;
