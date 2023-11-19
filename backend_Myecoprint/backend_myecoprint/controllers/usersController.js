// controllers/UserController.js

const User = require('../models/User');
const multer = require('multer');
const path = require('path');
const fs = require('fs');

const storage = multer.diskStorage({
  destination: 'uploads/',
  filename: function (req, file, cb) {
    cb(null, Date.now() + path.extname(file.originalname));
  },
});

exports.createUser = async (req, res) => {
  try {
    const user = await User.create(req.body);
    res.json(user);
  } catch (error) {
    res.status(400).json({ error: 'Failed to create User', details: error.message });
  }
};



exports.uploadUserPhoto = (req, res) => {
 
  const userData = req.body;
  const newProfilePicture = req.file.path;
  User.update(userData, { where: { id: userData.id } })
    .then(() => {

      User.update({ profile_picture: newProfilePicture }, { where: { id: userData.id } })
        .then(() => {
          res.status(200).send('User data and photo updated successfully');
        })
        .catch((error) => {
          res.status(500).send('Error updating user photo');
        });
    })
    .catch((error) => {
      res.status(500).send('Error updating user data');
    });
};

exports.getAllUsers = async (req, res) => {
  try {
    const users = await User.findAll();
    res.json(users);
  } catch (error) {
    res.status(400).json({ error: 'Failed to fetch Users', details: error.message });
  }
};



exports.getUserById = async (req, res) => {
  const UserId = req.params.id;

  try {
    const user = await User.findByPk(UserId);
    if (!user) {
      return res.status(404).json({ error: 'User not found' });
    }
    res.json(user);
  } catch (error) {
    res.status(400).json({ error: 'Failed to fetch the User', details: error.message });
  }
};

exports.updateUser =  async (req, res) => {
    try {
      const authObject = req.user;
  
      const payload = req.body;
  
      const user = await User.findOne({ _id: authObject.id });
  
      if (!user) {
        return res.status(404).json({ error: 'User not found' });
      }
  
     
      user.username = payload.username;
      user.email = payload.email;
      user.phone=payload.phone;
  
      if (req.file) {
        const imageName = req.file.filename;
        user.image = `uploads/${imageName}`;
      }
  
      const password = req.body.password;
      if (password && password.length > 0) {
        user.password = password;
      }
  
      await user.save();
  
      return res.json(user);
    } catch (ex) {
      console.log(ex);
      return res.status(400).json({ message: ex.toString() });
    }
  }


  exports.deleteUser = async (req, res) => {
    const userId = req.params.id;
  
    try {
      const deleted = await User.destroy({
        where: { user_id: userId },
      });
      if (!deleted) {
        return res.status(404).json({ error: 'User not found or not deleted' });
      }
      res.json({ message: 'User deleted successfully' });
    } catch (error) {
      res.status(400).json({ error: 'Failed to delete the User', details: error.message });
    }
  };
  