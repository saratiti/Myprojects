
const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');
const Company = require('./company');
const Type = require('./type');

const Store = sequelize.define('Store', {
    store_id: {
    type: DataTypes.INTEGER,
    allowNull: false,
    primaryKey: true,
    autoIncrement: true,
  },
  name_arabic: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  name_english: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  company_id: {
    type: DataTypes.INTEGER,
    allowNull: false,
  },
  type_id: {
    type: DataTypes.INTEGER,
    allowNull: false,
  },  
  image: {
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
    tableName: 'stores', 
  });
  Store.belongsTo(Company, { foreignKey: 'company_id', as: 'companies',onDelete: 'CASCADE' });
  Store.belongsTo(Type, { foreignKey: 'type_id', as: 'types',onDelete: 'CASCADE' });
 // Store.hasMany(Offer, { foreignKey: 'store_id', as: 'offers' });
module.exports = Store;








