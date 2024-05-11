
const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');
const User = require('./user'); 
const Order = require('./Order'); 
const Invoice = sequelize.define('Invoice', {
  invoice_id: {
    type: DataTypes.BIGINT,
    primaryKey: true,
    autoIncrement: true
  },
  upload_date: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  file_path: {
    type: DataTypes.STRING,
  
  },
  total_amount: {
    type: DataTypes.DOUBLE,
    allowNull: false,
  },
  user_id: {
    type: DataTypes.BIGINT,
    
  },
  order_id:{
    type: DataTypes.BIGINT,
  },
  createdAt: {
    type: DataTypes.DATE,
    allowNull: true,
  },
  updatedAt: {
    type: DataTypes.DATE,
    allowNull: true,
  },
  deletedAt: {
    type: DataTypes.DATE,
    allowNull: true,
  }
  },{
  timestamps: false, 
  paranoid: true,
  tableName: 'invoices',
  
  });
  Invoice.belongsTo(Order, { foreignKey: 'order_id', as: 'orders',key: 'order_id', onDelete: 'CASCADE' });
  Invoice.belongsTo(User, { foreignKey: 'user_id', as: 'users',key: 'id', onDelete: 'CASCADE' });

module.exports = Invoice;
