

const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');


const Category = sequelize.define('Category', {
  category_id: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true
  },
  name_arabic: {
    type: DataTypes.STRING,
    allowNull: true
  },
  name_english: {
    type: DataTypes.STRING,
    allowNull: true
  },
  logo: {
    type: DataTypes.STRING,
    allowNull: true
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
}, {
timestamps: false, 
  paranoid: true,
  tableName: 'categories',
  
});

module.exports = Category;
