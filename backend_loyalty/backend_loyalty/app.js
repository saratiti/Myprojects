
const express = require('express');
require('dotenv').config()

const app = express();
const sequelize = require('./config/database');
const bodyParser = require('body-parser');
const jwt = require('jsonwebtoken');
const axios = require('axios');
const fs = require('fs');
const path = require('path');

const { Client } = require('ssh2');

const categoriesRoutes = require('./routes/categories');
const usersRoutes = require('./routes/users');
const loyaltiesRouted=require('./routes/loyalty');
const authRoutes = require('./routes/auth');
const challengesRoutes = require('./routes/challenges');
const invitePersonRoutes = require('./routes/invitePersons');
const invoiceRoutes = require('./routes/invoices');
const optionMenueRoutes = require('./routes/optionalMenu');
const orderRoutes = require('./routes/order');
const productRoutes = require('./routes/products');
const orderProductRoutes = require('./routes/orderProduct');
const reviewRoutes = require('./routes/reviews');
const transactionsRouter=require('./routes/transaction');
const userChallengesRouter=require('./routes/userChallenge');
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(bodyParser.json());


app.use('/api/categories', categoriesRoutes);
app.use('/api/challenges', challengesRoutes);
app.use('/api/users', usersRoutes);
app.use('/api/auth', authRoutes);
app.use('/api/invite_person', invitePersonRoutes);
app.use('/api/invoices', invoiceRoutes);
app.use('/api/optionMenue', optionMenueRoutes);
app.use('/api/orders', orderRoutes );
app.use('/api/product', productRoutes );
app.use('/api/orderProduct',orderProductRoutes);
app.use('/api/reviews',reviewRoutes);
app.use('/api/transactions', transactionsRouter);
app.use('/api/loyalty', loyaltiesRouted);
app.use('/api/userChallenge', userChallengesRouter);
sequelize.sync()
  .then(() => {
    console.log('Database tables synced');
  })
  .catch((error) => {
    console.error('Error syncing database:', error);
  });

  const uploadDirectory = '/var/www/backend_myecoprint/'; 

// app.get('/api/images/:imageName', async (req, res) => {
//   try {
//     const { imageName } = req.params;
//     const localImagePath = path.join(uploadDirectory, imageName);

//     if (!fs.existsSync(localImagePath)) {
//       await copyImageFromServer(imageName, localImagePath);
//     }

//     if (!fs.existsSync(localImagePath)) {
//       return res.status(404).json({ error: 'Image not found' });
//     }
//     const ext = path.extname(localImagePath).toLowerCase();
//     let contentType;
//     switch (ext) {
//       case '.jpg':
//       case '.jpeg':
//         contentType = 'image/jpeg';
//         break;
//       case '.png':
//         contentType = 'image/png';
//         break;
//       case '.gif':
//         contentType = 'image/gif';
//         break;
//       default:
//         contentType = 'application/octet-stream';
//     }

//     res.sendFile(localImagePath, { headers: { 'Content-Type': contentType } });
//   } catch (error) {
//     console.error('Error serving image:', error);
//     res.status(500).json({ error: 'Internal server error' });
//   }
// });

// async function copyImageFromServer(imageName, localImagePath) {
//   const sshConfig = {
//     host: '94.156.35.189',
//     port: 22,
//     username: 'root',
//     password: 'DuC2Gkz58PSyNkC'
//   };

//   return new Promise((resolve, reject) => {
//     const conn = new Client();
//     conn.on('ready', () => {
//       conn.sftp((err, sftp) => {
//         if (err) {
//           reject(err);
//           return;
//         }
//         const remoteImagePath = `/var/www/backend_myecoprint/uploads/${imageName}`;
//         sftp.fastGet(remoteImagePath, localImagePath, err => {
//           if (err) {
//             reject(err);
//           } else {
//             resolve();
//           }
//           conn.end();
//         });
//       });
//     }).connect(sshConfig);
//   });
// }

const port = process.env.PORT || 3000;

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});