
const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const reasonBarcode = sequelize.define('reasonBarcode', {
  reasonBarcode_id: {
    type: DataTypes.INTEGER,
    allowNull: false,
    primaryKey: true,
    autoIncrement: true,
  },
  reason_arabic: {
    type: DataTypes.STRING,
    allowNull: false,
  },

  reason_english: {
    type: DataTypes.STRING,
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
  },
}, {
    timestamps: false, 
    paranoid: true, 
    tableName: 'reason_barcodes', 
  });

module.exports = reasonBarcode;










