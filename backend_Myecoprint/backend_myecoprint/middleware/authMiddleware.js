const cacheUtil = require('../utils/cache');
const jwtUtil = require('../utils/jwt.util');

module.exports = async (req, res, next) => {

    let token = req.headers.authorization;
    if (token && token.startsWith('Bearer ')) {
        token = token.slice(7, token.length);
    }

    if (token) {
        try {
            token = token.trim();
            /* ---------------------- Check For Blacklisted Tokens ---------------------- */
            const isBlackListed = await cacheUtil.get(token);
            if (isBlackListed) {
                return res.status(401).json({ message: 'Unauthorized' });
            }
         
            
            const decoded = await jwtUtil.verifyToken(token);
            req.user = decoded;
            req.token = token;
            next();
        } catch (error) {
            return res.status(401).json({ message: 'Unauthorized' });
        }
    } else {
        return res.status(400).json({ message: 'Authorization header is missing.' })
    }
}

//middleware/authMiddleware.js

// middleware/authMiddleware.js
const jwt = require('jsonwebtoken');
const { ACCESS_TOKEN_SECRET } = process.env;

function authenticateToken(req, res, next) {
    const token = req.headers.authorization;

    if (!token || !token.startsWith('Bearer ')) {
        return res.status(401).json({ message: 'Unauthorized' });
    }

    const accessToken = token.replace('Bearer ', '');

    try {
        const decoded = jwt.verify(accessToken, ACCESS_TOKEN_SECRET);
        req.user = decoded;
        req.user_id = decoded.user_id; // Assuming user_id is included in your JWT payload
        next();
    } catch (error) {
        return res.status(401).json({ message: 'Unauthorized' });
    }
}

module.exports = {
    authenticateToken,
};




module.exports = {
  authenticateToken,
};
