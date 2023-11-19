
const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');
//const Store= require('./store');

const Branche = sequelize.define('Branche', {
  branch_id: {
    type: DataTypes.INTEGER,
    allowNull: false,
    primaryKey: true,
    autoIncrement: true,
  },
  store_id: {
    type: DataTypes.INTEGER,
  },
  email: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  password: {
    type: DataTypes.STRING,
    allowNull: false,
  },

  location: {
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
  tableName: 'branches',
});
//Branche.belongsTo(Store, { foreignKey: 'store_id', as: 'stores',onDelete: 'CASCADE' });
module.exports = Branche;












