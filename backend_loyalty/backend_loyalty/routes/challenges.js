

const express = require('express');
const router = express.Router();
const challengeController = require('../controllers/challengeController');


router.get('/', challengeController.getAllChallenges);


router.post('/', challengeController.createChallenge);

module.exports = router;
