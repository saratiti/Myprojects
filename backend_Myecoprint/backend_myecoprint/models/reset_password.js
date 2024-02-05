
const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');
const User = require('./user');

const resetPassword = sequelize.define('resetPassword', {
    reset_password_id: {
    type: DataTypes.INTEGER,
    allowNull: false,
    primaryKey: true,
    autoIncrement: true,
  },
  pin_code: {
    type: DataTypes.STRING,
    allowNull: false,
  
  },
  
  timestamp: {
    type: DataTypes.DATE,
    
    allowNull: true,
  },
  user_id: {
    type: DataTypes.INTEGER,
    references: {
      model: User,
      key: 'user_id',
    },
    allowNull: true,
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
  tableName: 'reset_password', 
});
resetPassword.belongsTo(User, { foreignKey: 'user_id', as: 'users', onDelete: 'CASCADE' });

module.exports = resetPassword;
