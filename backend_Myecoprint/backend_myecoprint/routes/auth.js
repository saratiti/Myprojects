const express = require('express');
const router = express.Router();
const jwt = require('jsonwebtoken');
const AuthController = require('../controllers/authController');
const ErrorHandler = require('../middleware/error.middleware');
const AuthGuard = require('../middleware/authMiddleware');
const schema = require('../validatons/auth');
const validate = require('../utils/validator.util');

router.post('/register', validate(schema.register), ErrorHandler(AuthController.register));
router.post('/login', AuthController.login);
router.get('/logout', AuthController.logout);

router.all('*', (req, res) => res.status(400).json({ message: 'Bad Request.' }))

module.exports = router;
