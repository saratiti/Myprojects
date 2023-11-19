const express = require('express');
const router = express.Router();
const contcatsController = require('../controllers/contcatsController');

router.post('/', contcatsController.createContcat);
router.get('/', contcatsController.getAllContcats);
router.get('/contcat/:id', contcatsController.getContatById);
router.put('/contcat/:id', contcatsController.updateContcat);
router.delete('/contcat/:id', contcatsController.deleteContcat);

module.exports = router;
