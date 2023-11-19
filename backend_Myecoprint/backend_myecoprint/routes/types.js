const express = require('express');
const router = express.Router();
const typeController = require('../controllers/typesController');

router.post('/types', typeController.createType);
router.get('/', typeController.getAllTypes);
router.get('/types/:id', typeController.getTypeById);
router.put('/types/:id', typeController.updateType);
router.delete('/types/:id', typeController.deleteType);

module.exports = router;
