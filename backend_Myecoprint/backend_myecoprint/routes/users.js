const express = require('express');
const router = express.Router();
const multer = require('multer');
const storage = multer.diskStorage({
    destination: 'uploads/', // Folder where uploaded files will be stored
    filename: function (req, file, cb) {
      cb(null, Date.now() + '-' + file.originalname);
    },
  });
  
  const upload = multer({ storage });
  
const userController = require('../controllers/usersController');
const ErrorHandler = require('../middleware/error.middleware');
const { authenticateToken } = require('../middleware/authMiddleware');
const schema = require('../validatons/auth');
const validate = require('../utils/validator.util');
//const passport = require('passport');
router.post('/', userController.createUser);
router.get('/', userController.getAllUsers);
router.get('/users/:id', userController.getUserById);
router.put('/users/:id', userController.updateUser);
router.post('/emailExists',userController.exitEmail);
router.post('/validPin',userController.validatePin);
router.delete('/:id', userController.deleteUser);
router.get('/profile', authenticateToken, (req, res) => {
    res.json(req.user);
  });
router.put('/update',authenticateToken, upload.single('image'),userController.updateUser)
router.post('/upload', authenticateToken, upload.single('photo'), userController.uploadUserPhoto);

module.exports = router;
