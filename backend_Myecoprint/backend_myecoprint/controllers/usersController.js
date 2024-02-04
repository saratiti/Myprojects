// controllers/UserController.js

const User = require('../models/User');
const multer = require('multer');
const path = require('path');
const fs = require('fs');
const randomatic = require('randomatic');
const nodemailer = require('nodemailer');
const crypto = require('crypto');


const storage = multer.diskStorage({
  destination: 'uploads/',
  filename: function (req, file, cb) {
    cb(null, Date.now() + path.extname(file.originalname));
  },
});
const otpStorage = {};
const getHashedOtp = (otp) => {
  const hash = crypto.createHash('sha256');
  hash.update(otp);
  return hash.digest('hex');
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
exports.sendRandomCode = async (req, res) => {
  try {
    const { email } = req.body;
    const code = generateRandomCode();

    // Store the generated code for later verification
    otpStorage[email] = hashOtp(code);

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


async function getHashedOtpFromStorage(email) {
  try {
    const user = await User.findOne({
      where: { email: email.toLowerCase() }
    });

    
    return user ? user.hashedOtp : null;
  } catch (error) {
    console.error(error);
    throw error;
  }
}
// This function should validate the received PIN code against the stored hashed OTP
function validateOtp(receivedOtp, storedHashedOtp) {
  // Replace this with your actual validation logic
  // For example, you might use a library like bcrypt to compare the received OTP with the stored hashed OTP
  // This is a placeholder, and you should replace it with your actual validation logic
  return receivedOtp === storedHashedOtp;
}
exports.validatePin = async (req, res) => {
  try {
    const { email, pinCode } = req.body;

    const isValid = true;  // Replace this with your logic to check the dynamically generated OTP

    if (isValid) {
      return res.status(200).json({ success: true, message: 'PIN code is valid' });
    } else {
      return res.status(400).json({ success: false, message: 'Invalid email or OTP' });
    }
  } catch (error) {
    console.error(error);
    return res.status(500).json({ error: 'Internal Server Error' });
  }
};



exports.exitEmail = async (req, res) => {
  try {
    const { email } = req.body;

    console.log('Received Email:', email);

    const existingUser = await User.findOne({
      where: { email: email.toLowerCase() } 
    });

    console.log('Existing User:', existingUser);

    if (existingUser) {
      console.log('Email found');

      // Generate and send the OTP
      const code = generateRandomCode();
      const emailSent = await sendRandomCodeEmail(email, code);

      if (emailSent) {
        // Store the hashed OTP in your storage (e.g., database, cache)
        const hashedOtp = hashOtp(code);
        // Save 'hashedOtp' along with user information in the database if needed

        return res.status(200).json({ success: true, message: 'Email found. Code sent successfully', exists: true });
      } else {
        return res.status(500).json({ success: false, message: 'Email found. Failed to send code to email', exists: true });
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


async function sendRandomCodeEmail(email, code) {
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

// Function to hash the OTP
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
  