
const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');


const User = sequelize.define('User', {
  id: {
    type: DataTypes.BIGINT.UNSIGNED,
    allowNull: false,
    primaryKey: true,
    autoIncrement: true,
  },
  // username: {
  //   type: DataTypes.STRING,
  //   allowNull: false,
  //   unique: true,
  // },
  email: {
    type: DataTypes.STRING,
    allowNull: false,
 
  },
  // full_name: {
  //   type: DataTypes.STRING,
  // },
  password: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  role: {
    type: DataTypes.STRING,
    allowNull: true,
   
  },
  // profile_picture: {
  //   type: DataTypes.STRING,
  // },
  phone: {
    type: DataTypes.STRING,
    
   
  },
  
// createdAt:{
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
  // deletedAt: {
  //   type: DataTypes.DATE,
  //   allowNull: true,
  // },
}, {
  timestamps: false, 
  paranoid: true, 
  tableName: 'users', 
});

module.exports = User;
