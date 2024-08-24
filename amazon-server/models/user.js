const mongoose = require('mongoose');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

const userSchema = mongoose.Schema({
    name: {
        type: String,
        required: true,
        trim: true,
    },
    email: {
        type: String,
        required: true,
        unique: true,
        trim: true,
        lowercase: true,
        validate: {
            validator: (value) => /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/.test(value),
            message: props => `${props.value} is not a valid email address!`,
        },
    },
    password: {
        type: String,
        required: true,
        minlength: 8,
    },
    address: {
        type: String,
        trim: true,
        default: '',
    },
    type: {
        type: String,
        enum: ['user', 'admin'],
        default: 'user',
    },
    createdAt: {
        type: Date,
        default: Date.now,
    },
    modifiedAt: {
        type: Date,
        default: Date.now,
    },
});

// Pre-save middleware to hash the password before saving
userSchema.pre('save', async function (next) {
    const user = this;

    // Only hash the password if it has been modified (or is new)
    if (!user.isModified('password')) return next();

    try {
        // Generate a salt
        const salt = await bcrypt.genSalt(10);
        // Hash the password using the salt
        const hashedPassword = await bcrypt.hash(user.password, salt);
        // Replace the plain text password with the hashed one
        user.password = hashedPassword;
        next();
    } catch (err) {
        next(err);
    }
});

// Method to compare given password with hashed password in the database
userSchema.methods.comparePassword = async function (candidatePassword) {
    return await bcrypt.compare(candidatePassword, this.password);
};

// Exclude createdAt and modifiedAt from JSON output
userSchema.set('toJSON', {
    transform: function (doc, ret, options) {
        delete ret.createdAt;
        delete ret.modifiedAt;
        delete ret.password;
        return ret;
    }
});

// Method to generate JWT token
userSchema.methods.generateAuthToken = function () {
    const token = jwt.sign(
        { _id: this._id, email: this.email },
        process.env.JWT_SECRET,
        {expiresIn: process.env.EXPIRES_IN},
    );
    return token;
};

module.exports = mongoose.model('User', userSchema);
