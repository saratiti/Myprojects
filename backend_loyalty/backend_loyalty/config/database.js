require ('dotenv').config()
const Sequelize = require('sequelize');

const sequelize = new Sequelize({
  dialect: 'mysql',
  host: 'localhost', 
  username:process.env.DB_USERNAME, 
  password:process.env. DB_PASSWORD, 
  database:process.env. DB_DATABASE,
  port:process.env. MYSQL_PORT,

});


  module.exports = sequelize;

