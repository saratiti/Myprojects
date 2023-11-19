const express = require('express');
const router = express.Router();
const companyController = require('../controllers/companiesController');

router.post('/', companyController.createCompany);
router.get('/', companyController.getAllCompanies);
router.get('/company/:id', companyController.getCompanyById);
router.put('/company/:id', companyController.updateCompany);
router.delete('/company/:id', companyController.deleteCompany);

module.exports = router;









