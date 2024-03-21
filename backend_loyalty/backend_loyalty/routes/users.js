const express = require('express');
const router = express.Router();
const multer = require('multer');
const path = require('path');
const { v4: uuidv4 } = require('uuid');

const storage = multer.diskStorage({
  destination: 'uploads/', // Folder where uploaded files will be stored
  filename: function (req, file, cb) {
    // Extract the file extension
    const fileExtension = path.extname(file.originalname);
    // Generate a unique filename based on the original name and extension
    const newFileName = `${uuidv4()}${fileExtension}`;
    cb(null, newFileName);
  },
});

const upload = multer({ storage });
const uploadMiddleware = upload.single('profile_picture');
  
const userController = require('../controllers/usersController');
const ErrorHandler = require('../middleware/error.middleware');
const { authenticateToken } = require('../middleware/authMiddleware');
const schema = require('../validatons/auth');
const validate = require('../utils/validator.util');
//const passport = require('passport');
router.post('/', userController.createUser);
router.get('/', userController.getAllUsers);
router.get('/users/:id', userController.getUserById);
router.put('/updateProfile/',authenticateToken, uploadMiddleware, userController.update);
router.post('/sendPinForEmail',userController.sendPinForEmailVerification);
router.post('/validPin',userController.validatePin);
router.post('/changedPassword',userController.changePassword);
router.delete('/:id', userController.deleteUser);
router.get('/profilePicture',authenticateToken, userController.getProfilePicture);
router.get('/profile', authenticateToken, (req, res) => {
    res.json(req.user);
  });
//router.put('/update',authenticateToken, upload.single('image'),userController.updateUser)
router.post('/upload', authenticateToken, upload.single('photo'), userController.uploadUserPhoto);
router.post('/uploadImage', upload.single('image'), (req, res) => {
  const imagePath = req.file.path;
  res.json({ imagePath });
});
module.exports = router;
