
const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');
const Store= require('./store');
const User=require('./user');
const Offer=require('./offer');
const Branch=require('./branche')
const Barcode = sequelize.define('Barcode', {

  barcode_id: {
    type: DataTypes.INTEGER,
    allowNull: false,
    primaryKey: true,
    autoIncrement: true,
  },
  store_id: {
    type: DataTypes.INTEGER,
    allowNull: false,
  },
  offer_id: {
    type: DataTypes.INTEGER,
    allowNull: false,
  },
  barcode_value: {
    type: DataTypes.STRING,
  },
  barcode_status: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  branch_id: {
    type: DataTypes.INTEGER,
    allowNull: false,
  },
  user_id: {
    type: DataTypes.INTEGER,
  },
  barcode_date: {
    type: DataTypes.DATE,
    allowNull: false,
  },
},);

Barcode.belongsTo(Store, { foreignKey: 'store_id', as: 'stores',onDelete: 'CASCADE' });
Barcode.belongsTo(Offer, { foreignKey: 'offer_id', as: 'offers',onDelete: 'CASCADE' });
Barcode.belongsTo(Branch, { foreignKey: 'branch_id', as: 'branches',onDelete: 'CASCADE' });
Barcode.belongsTo(User, { foreignKey: 'user_id', as: 'users',onDelete: 'CASCADE' });

module.exports = Barcode;
