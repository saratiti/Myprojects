// controllers/UserController.js

const User = require('../models/User');
const multer = require('multer');
const path = require('path');
const fs = require('fs');
const randomatic = require('randomatic');
const nodemailer = require('nodemailer');
const crypto = require('crypto');
const { Op } = require('sequelize');
const bcrypt = require('bcrypt');
const PasswordResetRequest=require('../models/reset_password');
const storage = multer.diskStorage({
  destination: 'uploads/',
  filename: function (req, file, cb) {
    cb(null, Date.now() + path.extname(file.originalname));
  },
});


exports.changePassword = async (req, res) => {
  const { email, currentPassword, newPassword } = req.body;

  try {
    const user = await User.findOne({  where: { email: email },});
    
    if (!user) {
      return res.status(404).json({ error: 'User not found' });
    }

    const isPasswordMatch = await bcrypt.compare(currentPassword, user.password);

    if (!isPasswordMatch) {
      return res.status(401).json({ error: 'Incorrect current password' });
    }

    const hashedPassword = await bcrypt.hash(newPassword, 10);

    
    user.password = hashedPassword;
    await user.save();

    return res.status(200).json({ message: 'Password updated successfully' });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ error: 'Internal Server Error' });
  }
};

exports.createUser = async (req, res) => {
  try {
    const user = await User.create(req.body);
    res.json(user);
  } catch (error) {
    console.error('Error creating user:', error.message);
    res.status(400).json({ error: 'Failed to create User', details: error.message });
  }
};
const otpStorage = {};

exports.sendRandomCode = async (req, res) => {
  try {
    const { email } = req.body;
    const code = generateRandomCode();

    // Store the hashed code in your otpStorage
    otpStorage[email] = await hashOtp(code);

    const emailSent = await sendRandomCodeEmail(email, code);

    if (emailSent) {
      return res.status(200).json({ success: true, message: 'Code sent successfully' });
    } else {
      return res.status(500).json({ success: false, message: 'Failed to send code to email' });
    }
  } catch (error) {
    console.error(error);
    return res.status(500).json({ error: 'Internal Server Error' });
  }
};

exports.validatePin = async (req, res) => {
  const enteredPin = req.body.pin;
  const recipientEmail = req.body.email;

  try {
    const user = await User.findOne({
      where: { email: recipientEmail },
    });

    if (!user) {
      return res.status(401).json({ success: false, message: 'User not found' });
    }

    const storedHashedPin = otpStorage[recipientEmail];

    console.log('Entered PIN:', enteredPin);
    console.log('Stored Hashed PIN:', storedHashedPin);

    if (!storedHashedPin || !(await bcrypt.compare(enteredPin, storedHashedPin))) {
    
      console.log('Incorrect PIN code');
      return res.status(401).json({ success: false, message: 'Incorrect PIN code' });
    }

   
    delete otpStorage[recipientEmail];

    const hashedPinResponse = await bcrypt.hash(enteredPin, 10);

    console.log('PIN code is correct');
    return res.status(200).json({
      success: true,
      message: 'PIN code is correct',
      hashedPin: hashedPinResponse,
    });
  } catch (err) {
    console.error(err);
    res.status(500).json({ success: false, message: 'Error verifying PIN code' });
  }
};



const hashPinCode = async (pinCode) => {
  const saltRounds = 10;
  const hashedPinCode = await bcrypt.hash(pinCode, saltRounds);
  return hashedPinCode;
};

exports.sendPinForEmailVerification = async (req, res) => {
  try {
    const { email } = req.body;

    console.log('Received Email:', email);

    const existingUser = await User.findOne({
      where: { email: email.toLowerCase() },
    });

    console.log('Existing User:', existingUser);

    if (existingUser) {
      console.log('Email found');

      
      const pinCode = generateRandomCode();
      const hashedPinCode = await hashPinCode(pinCode);

      
      otpStorage[email] = hashedPinCode;

      const emailSent = await sendPinCodeEmail(email, pinCode);

      if (emailSent) {
        return res.status(200).json({ success: true, message: 'Email found. PIN code sent successfully', exists: true });
      } else {
        return res.status(500).json({ success: false, message: 'Email found. Failed to send PIN code to email', exists: true });
      }
    } else {
      console.log('Email not found');
      return res.status(200).json({ success: true, message: 'Email not found', exists: false });
    }
  } catch (error) {
    console.error(error);
    return res.status(500).json({ error: 'Internal Server Error' });
  }
};


async function sendPinCodeEmail(email, code) {
  try {
    const transporter = nodemailer.createTransport({
      service: 'gmail',
      auth: {
        user: 'titisara569@gmail.com',
        pass: 'krvkitqvrzxaokqm',
      },
    });

    const mailOptions = {
      from: 'titisara569@gmail.com',
      to: email,
      subject: 'Random Code',
      text: `Your random code is: ${code}`,
    };

    await transporter.sendMail(mailOptions);
    return true;
  } catch (error) {
    console.error(error);
    return false;
  }
}

function generateRandomCode() {
  return Math.floor(100000 + Math.random() * 900000).toString();
}


function hashOtp(otp) {
  return crypto.createHash('sha256').update(otp).digest('hex');
}


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
  