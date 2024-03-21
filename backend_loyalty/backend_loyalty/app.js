
const express = require('express');
require('dotenv').config()

const app = express();
const sequelize = require('./config/database');
const bodyParser = require('body-parser');
const jwt = require('jsonwebtoken');


const categoriesRoutes = require('./routes/categories');
const usersRoutes = require('./routes/users');
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
app.use('/api/invoice', invoiceRoutes);
app.use('/api/optionMenue', optionMenueRoutes );
app.use('/api/order', orderRoutes );
app.use('/api/product', productRoutes );
app.use('/api/orderProduct',orderProductRoutes);
app.use('/api/review',reviewRoutes);
app.use('/api/transactions', transactionsRouter);
app.use('/api/userChallenge', userChallengesRouter);
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