const User = require('../models/user');

module.exports.signUp = async (req, res) => {
    try {
        const { username, email, password } = req.body;
        if (!username) {
            throw Error('Username must be provided');
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

        const user = await User.create({ username, email, password });

        const accessToken = user.generateAuthToken();

        res.status(201).json({
            success: true,
            data: {
                user,
                accessToken,
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
        const isMatch = await bcrypt.compare(password, user.password);
        if (!isMatch) {
            return res.status(400).json({ message: 'Invalid email or password.' });
        }

        // Generate JWT token
        const accessToken = jwt.sign(
            { _id: user._id, email: user.email },
            process.env.JWT_SECRET,
            { expiresIn: '1000d' } // Set expiration to 1000 days
        );

        // Return the token and user information
        res.status(200).json({
            success: true,
            data: {
                user,
                accessToken,
            },
        });
    } catch (error) {
        res.status(400).json({
            success: false,
            message: error.message,
        });
    }
};
