

const OptionalMenu = require('../models/OptionalMenu');

exports.getAllOptionalMenus = async (req, res) => {
  try {
    const optionalMenus = await OptionalMenu.findAll();
    res.json(optionalMenus);
  } catch (error) {
    console.error('Error retrieving optional menus:', error.message);
    res.status(500).send('Server Error');
  }
};

exports.createOptionalMenu = async (req, res) => {
  try {
    const newOptionalMenu = await OptionalMenu.create(req.body);
    res.status(201).json({ message: 'Optional menu created successfully', newOptionalMenu });
  } catch (error) {
    console.error('Error creating optional menu:', error.message);
    res.status(500).send('Server Error');
  }
};
