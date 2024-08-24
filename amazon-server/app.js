const express = require('express');
const app = express();

const helmet = require('helmet');
const compression = require('compression');

// Middleware for security
app.use(helmet());

// Middleware for performance
app.use(compression());

// Middleware for parsing JSON
app.use(express.json());

// Base API route
const apiV1 = '/api/v1';

const authRouter = require('./routes/auth');
app.use(`${apiV1}/auth`, authRouter);

module.exports = app;
