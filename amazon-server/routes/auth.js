const express = require('express');
const authRouter = express.Router();

const authorization = require('../middlewares/authorization');

const { signUp, signIn, checkAccessToken } = require('../controllers/auth-controller');

authRouter.post('/sign-up', signUp);

authRouter.post('/sign-in', signIn);

authRouter.post('/check-access-token', authorization, checkAccessToken);

module.exports = authRouter;
