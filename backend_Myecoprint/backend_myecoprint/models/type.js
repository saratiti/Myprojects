
const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');
const Store= require('./store');
const Type = sequelize.define('Type', {
    type_id: {
    type: DataTypes.INTEGER,
    allowNull: false,
    primaryKey: true,
    autoIncrement: true,
  },
  type_arabic: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  type_english: {
    type: DataTypes.STRING,
    allowNull: false,
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
    tableName: 'types', 
  });
  

module.exports = Type;




