
const express = require('express');
require ('dotenv').config()

const app = express();
const sequelize = require('./config/database');
const bodyParser = require('body-parser');
const jwt=require('jsonwebtoken');


const barcodesRouter = require('./routes/barcodes');
const branchesRouter = require('./routes/branches');
const companiesRouter = require('./routes/companies');
const contcatsRouter = require('./routes/contcats');
const informationContactsRouter = require('./routes/informations_contacts');
const offersRouter = require('./routes/offers');
const pointRouter = require('./routes/points');
const reasonBarcodesRouter = require('./routes/reasones_barcodes');
const storeRouter = require('./routes/stores');
const typeRouter = require('./routes/types');
const usersRouter = require('./routes/users');
const authRoutes = require('./routes/auth');
const redemRoutes = require('./routes/offer_redemption');
const transactionsRouter=require('./routes/transaction');
const qrCodeDirectory = 'public/qrcode';

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(bodyParser.json());

app.use('/public/qrcode', express.static(qrCodeDirectory));

app.use('/api/barcodes',barcodesRouter);
app.use('/api/branches',branchesRouter);
app.use('/api/companies',companiesRouter);
app.use('/api/contcats',contcatsRouter);
app.use('/api/information_contacts',informationContactsRouter);
app.use('/api/offers', offersRouter);
app.use('/api/points',pointRouter);
app.use('/api/reasones_barcodes',reasonBarcodesRouter);
app.use('/api/stores',storeRouter);
app.use('/api/types',typeRouter);
app.use('/api/users', usersRouter);
app.use('/api/transactions', transactionsRouter);
app.use('/api/auth', authRoutes);
app.use('/api/redeem_points', redemRoutes);


sequelize.sync()
  .then(() => {
    console.log('Database tables synced');
  })
  .catch((error) => {
    console.error('Error syncing database:', error);
  });



const port = process.env.PORT || 3000;

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});