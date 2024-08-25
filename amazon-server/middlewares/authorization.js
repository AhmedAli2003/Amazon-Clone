const jwt = require('jsonwebtoken');

module.exports = (req, res, next) => {
    // Extract the token from the Authorization header
    const token = req.header('Authorization')?.replace('Bearer ', '');

    if (!token) return res.status(401).json({
        success: false,
        message: 'Access denied. No token provided.',
    });

    try {
        // Verify the token using the secret key
        const decoded = jwt.verify(token, process.env.JWT_SECRET);

        // Attach the decoded user information to the request object
        req.user = decoded;

        // Allow the request to proceed
        next();
    } catch (error) {
        return res.status(401).json({
            success: false,
            message: 'Access denied. Invalid token.',
        });
    }
};
