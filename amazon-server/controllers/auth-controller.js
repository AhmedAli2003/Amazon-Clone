const User = require('../models/user');

module.exports.signUp = async (req, res) => {
    try {
        const { name, email, password } = req.body;
        if (!name) {
            throw Error('name must be provided');
        }
        if (!email) {
            throw Error('Email must be provided');
        }
        if (!password) {
            throw Error('Password must be provided');
        }

        const existingUser = await User.findOne({ email });
        if (existingUser) {
            throw Error('Email already exists');
        }

        const user = await User.create({ name, email, password });

        const accessToken = user.generateAuthToken();

        res.status(201).json({
            success: true,
            data: {
                user,
                accessToken,
                expiresIn: process.env.EXPIRES_IN,
            },
        });

    } catch (error) {
        res.status(400).json({
            success: false,
            message: error.message,
        });
    }
};

module.exports.signIn = async (req, res) => {
    try {
        const { email, password } = req.body;

        if (!email) {
            throw Error('Email must be provided');
        }
        if (!password) {
            throw Error('Password must be provided');
        }

        // Check if the user exists
        const user = await User.findOne({ email });
        if (!user) {
            return res.status(400).json({ message: 'Invalid email or password.' });
        }

        // Validate the password
        const isMatch = await user.comparePassword(password);
        if (!isMatch) {
            return res.status(400).json({ message: 'Invalid email or password.' });
        }

        // Generate JWT token
        const accessToken = user.generateAuthToken();

        // Return the token and user information
        res.status(200).json({
            success: true,
            data: {
                user,
                accessToken,
                expiresIn: process.env.EXPIRES_IN,
            },
        });
    } catch (error) {
        res.status(400).json({
            success: false,
            message: error.message,
        });
    }
};
