// models/ScannedInvoice.js

const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');
const User = require('./user');
const Invoice= require('./invoice');

const ScannedInvoice = sequelize.define('ScannedInvoice', {
  id: {
    type: DataTypes.BIGINT.UNSIGNED,
    allowNull: false,
    primaryKey: true,
    autoIncrement: true,
  },
  user_id: {
    type: DataTypes.BIGINT.UNSIGNED,
    allowNull: false,
  
  },
  invoice_id: {
    type: DataTypes.BIGINT.UNSIGNED,
    allowNull: false,
  
  },
  scanned_date: {
    type: DataTypes.DATE,
    allowNull: false,
    defaultValue: DataTypes.NOW
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
  paranoid: true,
  tableName: 'scan_invoices'
});

ScannedInvoice.belongsTo(User, { foreignKey: 'user_id', as: 'users', onDelete: 'CASCADE' });
//ScannedInvoice.belongsTo(Invoice, { foreignKey: 'invoice_id', as: 'invoices', onDelete: 'CASCADE' });

module.exports = ScannedInvoice;
