
const informationContact = require('../models/informations_contact');
const Store = require('../models/store');

exports.createinformationContact = async (req, res) => {
  try {
    const informationcontact = await informationContact.create(req.body);
    res.json(informationcontact);
  } catch (error) {
    res.status(400).json({ error: 'Failed to create informationContact', details: error.message });
  }
};

exports.getAllinformationContacts = async (req, res) => {
  try {
    const informationcontacts = await informationContact.findAll({
        include: [
          { model: Store, as: 'stores' },
         
        ]
      });
    res.json(informationcontacts);
  } catch (error) {
    res.status(400).json({ error: 'Failed to fetch informationContact', details: error.message });
  }
};

exports.getinformationContactById = async (req, res) => {
  const informationContactId = req.params.id;

  try {
    const informationcontact = await informationContact.findByPk(informationContactId);
    if (!informationcontact) {
      return res.status(404).json({ error: 'informationContact not found' });
    }
    res.json(informationcontact);
  } catch (error) {
    res.status(400).json({ error: 'Failed to fetch the informationContact', details: error.message });
  }
};

exports.updateinformationContact = async (req, res) => {
  const informationContactId = req.params.id;

  try {
    const [updated] = await informationContact.update(req.body, {
      where: {info_contact_id: informationContactId },
    });
    if (!updated) {
      return res.status(404).json({ error: 'informationContact not found or not updated' });
    }
    const updatedinformationcontact = await informationContact.findByPk(informationContactId );
    res.json(updatedinformationcontact);
  } catch (error) {
    res.status(400).json({ error: 'Failed to update the informationContact', details: error.message });
  }
};

exports.deleteinformationContact = async (req, res) => {
  const informationContactId = req.params.id;

  try {
    const deleted = await informationContact.destroy({
      where: { info_contact_id: informationContactId },
    });
    if (!deleted) {
      return res.status(404).json({ error: 'informationContact not found or not deleted' });
    }
    res.json({ message: 'informationContact deleted successfully' });
  } catch (error) {
    res.status(400).json({ error: 'Failed to delete the informationContact', details: error.message });
  }
};
