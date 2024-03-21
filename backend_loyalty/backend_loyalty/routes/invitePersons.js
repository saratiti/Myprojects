

const express = require('express');
const router = express.Router();
const invitePersonController = require('../controllers/invitePersonController');



router.get('/', invitePersonController.getAllInvites);



router.post('/', invitePersonController.createInvite);

module.exports = router;
