
const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');
const Company = require('./company');

const User = sequelize.define('User', {
  user_id: {
    type: DataTypes.INTEGER,
    allowNull: false,
    primaryKey: true,
    autoIncrement: true,
  },
  username: {
    type: DataTypes.STRING,
    allowNull: false,
    unique: true,
  },
  email: {
    type: DataTypes.STRING,
    allowNull: false,
 
  },
  full_name: {
    type: DataTypes.STRING,
  },
  password: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  user_type: {
    type: DataTypes.STRING,
    allowNull: true,
   
  },
  profile_picture: {
    type: DataTypes.STRING,
  },
  phone: {
    type: DataTypes.STRING,
    allowNull: false,
   
  },
  company_id: {
    type: DataTypes.INTEGER,
    references: {
      model: Company,
      key: 'company_id',
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
  tableName: 'users', 
});
User.belongsTo(Company, { foreignKey: 'company_id', as: 'companies', onDelete: 'CASCADE' });

module.exports = User;
