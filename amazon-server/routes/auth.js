const express = require('express');

const authRouter = express.Router();

authRouter.post('/sign-up', (req, res) => {
    const {username, email, password} = req.body;
    
});

authRouter.post('/sign-in', (req, res) => {

});

module.exports = authRouter;
