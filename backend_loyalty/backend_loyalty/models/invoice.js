
const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');
const User = require('./User'); 

const Invoice = sequelize.define('Invoice', {
  invoice_id: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true
  },
  upload_date: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  file_path: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  user_id: {
    type: DataTypes.INTEGER,
    
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
Invoice.belongsTo(User, { foreignKey: 'user_id', as: 'users', onDelete: 'CASCADE' });

module.exports = Invoice;
