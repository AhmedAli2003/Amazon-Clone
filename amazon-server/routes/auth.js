const express = require('express');
const authRouter = express.Router();

const { signUp, signIn } = require('../controllers/auth-controller');

authRouter.post('/sign-up', signUp);

authRouter.post('/sign-in', signIn);

module.exports = authRouter;
