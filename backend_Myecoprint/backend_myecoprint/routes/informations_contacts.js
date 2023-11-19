const express = require('express');
const router = express.Router();
const informationContactsController = require('../controllers/informations_contactsController');

router.post('/', informationContactsController.createinformationContact);
router.get('/', informationContactsController.getAllinformationContacts);
router.get('/informationContactss/:id', informationContactsController.getinformationContactById );
router.put('/informationContactss/:id', informationContactsController.updateinformationContact );
router.delete('/informationContactss/:id', informationContactsController.deleteinformationContact);

module.exports = router;







