
const express = require('express');
const router = express.Router();
const userChallengeController = require('../controllers/userChallengeController');


router.post('/', userChallengeController.createUserChallenge);

module.exports = router;
