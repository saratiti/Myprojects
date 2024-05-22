

const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');


const Category = sequelize.define('Category', {
  id: {
    type: DataTypes.BIGINT.UNSIGNED,
    allowNull: false,
    primaryKey: true,
    autoIncrement: true,
  },
  
  name_arabic: {
    type: DataTypes.STRING,
    allowNull: true
  },
  name_english: {
    type: DataTypes.STRING,
    allowNull: true
  },
  image: {
    type: DataTypes.STRING,
    allowNull: true
  },

  // createdAt:{
  //   type: DataTypes.DATE,
  //   allowNull: true,
  // },
  
  // updatedAt: {
  //   type: DataTypes.DATE,
  //   allowNull: true,
  // },
  // deletedAt: {
  //   type: DataTypes.DATE,
  //   allowNull: true,
  // },
  created_at: {
    type: DataTypes.DATE,
    allowNull: true,
  },
  updated_at: {
    type: DataTypes.DATE,
    allowNull: true,
  },
  // deleted_At: {
  //   type: DataTypes.DATE,
  //   allowNull: true,
  // }
}, {
timestamps: false, 
  paranoid: true,
  tableName: 'categories',
  
});

module.exports = Category;
