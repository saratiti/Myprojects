
const jwt = require('jsonwebtoken');
const User = require('../models/user');
const AuthService = require('../services/auth.service');
const jwtConfig = require('../config/jwt');
const bcryptUtil = require('../utils/ bcrypt');
const jwtUtil = require('../utils/jwt.util');


exports.login = (req, res) => {
  const { email, password } = req.body;

  User.findOne({
    where: {
      email: email,
    },
  })
    .then((user) => {
      if (user) {
        bcrypt.compare(password, user.password, (err, result) => {
          if (err) {
            console.error(err);
            res.status(500).json({ message: 'Internal Server Error' });
          } else if (result) {
            const payload = {
              user_id: user.user_id,
              username: user.username,
              email: user.email,
              full_name: user.full_name,
              phone: user.phone,
              user_type: user.user_type,
              company_id: user.company_id,
            };

            const accessToken = jwt.sign(payload, process.env.ACCESS_TOKEN_SECRET);
            res.status(200).json({ accessToken, company_id: user.company_id });
          } else {
            res.status(401).json({ message: 'Invalid credentials' });
          }
        });
      } else {
        res.status(401).json({ message: 'Invalid credentials' });
      }
    })
    .catch((error) => {
      console.error(error);
      res.status(500).json({ message: 'Internal Server Error' });
    });
};


exports.register = async (req, res) => {
  const isExist = await AuthService.findUserByusername(req.body.username);
  if (isExist) {
    return res.status(400).json({ message: 'Username already exists.' });
  }
  const hashedPassword = await bcryptUtil.createHash(req.body.password);
  const userData = {
    name: req.body.name,
    username: req.body.username,
    email: req.body.email, 
    full_name:req.body.full_name,
    password: hashedPassword,
  };

  const user = await AuthService.createUser(userData);
  return res.json({
    data: user,
    message: 'User registered successfully.',
  });
};




exports.logout = async (req, res) => {

  const authorizationHeader = req.headers['authorization'];
  if (!authorizationHeader) {
    return res.status(400).json({ message: 'Token is missing or invalid.' });
  }
  const token = authorizationHeader.split(' ')[1];
  jwt.verify(token, process.env.ACCESS_TOKEN_SECRET, (err, decoded) => {
    if (err) {
      return res.status(403).json({ message: 'Forbidden' });
    }
    AuthService.logoutUser(token, decoded.exp);

    return res.json({ message: 'Logged out successfully.' });
  });
};




const bcrypt = require('bcryptjs'); 


const saltRounds = 10;
const plainTextPassword = 'your_password_here';
bcrypt.hash(plainTextPassword, saltRounds, (err, hash) => {
  if (err) {
    console.error('Error hashing password:', err);
  } else {
    console.log('Hashed password:', hash);
  }
});


const hashedPassword = 'previously_hashed_password';
bcrypt.compare(plainTextPassword, hashedPassword, (err, result) => {
  if (err) {
    console.error('Error comparing passwords:', err);
  } else if (result) {
    console.log('Passwords match');
  } else {
    console.log('Passwords do not match');
  }
});
