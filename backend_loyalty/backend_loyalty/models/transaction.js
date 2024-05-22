const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');
const User = require('./user');

const Transaction = sequelize.define('Transaction', {
  id: {
    type: DataTypes.BIGINT.UNSIGNED,
    allowNull: false,
    primaryKey: true,
    autoIncrement: true,
  },
  user_id: {
    type: DataTypes.BIGINT.UNSIGNED,
   
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
  created_at: {
    type: DataTypes.DATE,
    allowNull: true,
  },
  updated_at: {
    type: DataTypes.DATE,
    allowNull: true,
  },
}, {
  timestamps: false,
  tableName: 'transactions',
});

Transaction.belongsTo(User,{ foreignKey: 'user_id',  as: 'users', key: 'id', onDelete: 'CASCADE' });

module.exports = Transaction;
