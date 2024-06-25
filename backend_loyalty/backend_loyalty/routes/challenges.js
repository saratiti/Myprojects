

const express = require('express');
const router = express.Router();
const challengeController = require('../controllers/challengeController');
const { authenticateToken } = require('../middleware/authMiddleware');

 router.get('/', challengeController.getAllChallenges);
router.get('/challengesProgress',authenticateToken,challengeController.processChallenges);

router.post('/', challengeController.createChallenge);

module.exports = router;
