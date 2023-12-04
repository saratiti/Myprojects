const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');
const User = require('./user');

const Transaction = sequelize.define('Transaction', {
  transaction_id: {
    type: DataTypes.INTEGER,
    allowNull: false,
    primaryKey: true,
    autoIncrement: true,
  },
  user_id: {
    type: DataTypes.INTEGER,
   
  },
  store_id: {
    type: DataTypes.INTEGER,
    allowNull: false,
  },
  offer_id: {
    type: DataTypes.INTEGER,
  },
  points: {
    type: DataTypes.INTEGER,
    allowNull: false,
  },
  transaction_type: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  transaction_date: {
    type: DataTypes.DATE,
    allowNull: false,
  },
}, {
  timestamps: false,
  tableName: 'transactions',
});

Transaction.belongsTo(User,{ foreignKey: 'user_id', as: 'user', onDelete: 'CASCADE' });

module.exports = Transaction;
