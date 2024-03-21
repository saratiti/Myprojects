
const InvitePerson = require('../models/invitePerson');

exports.getAllInvites = async (req, res) => {
  try {
    const invites = await InvitePerson.findAll();
    res.json(invites);
  } catch (error) {
    console.error('Error retrieving invites:', error.message);
    res.status(500).send('Server Error');
  }
};

exports.createInvite = async (req, res) => {
  try {
    const newInvite = await InvitePerson.create(req.body);
    res.status(201).json({ message: 'Invite created successfully', newInvite });
  } catch (error) {
    console.error('Error creating invite:', error.message);
    res.status(500).send('Server Error');
  }
};
