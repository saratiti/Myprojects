

const User = require('../models/user');
const multer = require('multer');
const path = require('path');
const fs = require('fs/promises');
const fsread = require('fs');
const randomatic = require('randomatic');
const nodemailer = require('nodemailer');
const crypto = require('crypto');
const { Op } = require('sequelize');
const bcryptjs = require('bcryptjs');
const bcrypt = require('bcrypt');
const Loyalty = require('../models/loyalty');
const storage = multer.diskStorage({
  destination: 'uploads/',
  filename: function (req, file, cb) {
    cb(null, Date.now() + path.extname(file.originalname));
  },
});


exports.changePassword = async (req, res) => {
  const {  newPassword, confirmPassword,email } = req.body;
 

  try {
    const user = await User.findOne({ where: { email: email } });

    if (!user) {
      return res.status(404).json({ error: 'User not found' });
    }

    if (newPassword !== confirmPassword) {
      return res.status(400).json({ error: 'New password and confirm password do not match' });
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
 
    const salt = await bcrypt.genSalt(10);
    
 
    const hashedPassword = await bcrypt.hash(req.body.password, salt);
    
    const user = await User.create({
      username: req.body.username,
      email: req.body.email,
      password: hashedPassword,
      full_name: req.body.full_name,
      user_type: req.body.user_type,
      profile_picture: req.body.profile_picture,
      phone: req.body.phone,
      company_id: req.body.company_id
    });

    const loyalty = await Loyalty.create({
      loyalty_point: 50, 
      loyalty_level: 'bronze',
      user_id: user.id,
      last_activity_date: new Date() 
    });

   
    res.json({ user, loyalty });
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
   
    const storedHashedPins = otpStorage[recipientEmail];

    console.log('Entered PIN:', enteredPin);
    console.log('Stored Hashed PINs:', storedHashedPins);

    if (!storedHashedPins || storedHashedPins.length === 0) {
      console.log('Stored Hashed PINs is empty');
      return res.status(401).json({ success: false, message: 'Stored Hashed PINs is empty' });
    }

    const isPinCorrect = storedHashedPins.some((storedHashedPin) => bcrypt.compareSync(enteredPin, storedHashedPin));

    if (!isPinCorrect) {
      console.log('Incorrect PIN code');
      return res.status(401).json({ success: false, message: 'Incorrect PIN code' });
    }

    console.log('PIN code is correct');
    return res.status(200).json({
      success: true,
      message: 'PIN code is correct',
      hashedPin: storedHashedPins[0], 
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

      if (!otpStorage[email]) {
        otpStorage[email] = [];
      }

      otpStorage[email].push(hashedPinCode);

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

exports.update = async (req, res) => {
  try {
    const { username, email, full_name, phone } = req.body;
    const authObject = req.user;
    const user = await User.findOne({ where: { id: authObject.user_id } });


    if (!user) {
      return res.status(404).json({ error: 'User not found' });
    }

    if (username) user.username = username;
    if (email) user.email = email;
    if (full_name) user.full_name = full_name;
    if (phone) user.phone = phone;

    if (req.file) {
      const profilePicturePath = req.file.path;
      const fileExtension = path.extname(req.file.originalname);
      const newFileName = `${user.user_id}${fileExtension}`;
      const newPath = path.join(__dirname, '..', 'uploads', newFileName);
      await fs.rename(profilePicturePath, newPath);

      
      if (user.user_type === 'company') {
       table
        const company = await Company.findOne({ where: { company_id: user.company_id } });
        if (company) {
          company.image = newPath;
          await company.save();
        } else {
          return res.status(404).json({ error: 'Company not found' });
        }
      } else {
       
        user.profile_picture = newPath;
      }
    }

    await user.save();

    const profilePictureUrl = user.profile_picture ? `http://yourserver.com/uploads/${path.basename(user.profile_picture)}` : '';
    res.status(200).json({ message: 'Profile updated successfully', profilePictureUrl });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Internal server error' });
  }
};

exports.getProfilePicture = async (req, res) => {
  try {
    const userId = req.user.id;

    const user = await User.findByPk(userId);

    if (!user) {
      return res.status(404).json({ error: 'User not found' });
    }

    let imagePath;

    if (user.user_type === 'company') {
     
      const company = await Company.findOne({ where: { company_id: user.company_id } });
      if (company && company.image) {
        imagePath = company.image;
      } else {
        return res.status(404).json({ error: 'Company profile picture not found' });
      }
    } else {
    
      imagePath = user.profile_picture;
    }

    if (!imagePath) {
      return res.status(204).send();
    }

    if (!fsread.existsSync(imagePath)) {
      return res.status(404).json({ error: 'Profile picture not found' });
    }

    const image = fsread.readFileSync(imagePath);
    const fileExtension = path.extname(imagePath).substr(1);
    let contentType;
    if (fileExtension === 'jpg' || fileExtension === 'jpeg') {
      contentType = 'image/jpeg';
    } else if (fileExtension === 'png') {
      contentType = 'image/png';
    } else {
      contentType = 'image/png';
    }

    res.setHeader('Content-Type', contentType);
    res.status(200).send(image);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Internal server error' });
  }
};

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
  