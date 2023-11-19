const express = require('express');
const router = express.Router();
const brancheController = require('../controllers/branchesController');

router.post('/branches', brancheController.createBranche);
router.get('/', brancheController.getAllBranches);
router.get('/branches/:id', brancheController.getBrancheById);
router.put('/branches/:id', brancheController.updateBranche);
router.delete('/branches/:id', brancheController.deleteBranche);

module.exports = router;




