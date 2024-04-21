
const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');
const OptionalMenu = require('./optionalMenu');
const Product= require('./product');

const optionProduct = sequelize.define('optionProduct', {
  option_product_id: {
    type: DataTypes.BIGINT,
    primaryKey: true,
    autoIncrement: true
  },
  option_id: {
    type: DataTypes.BIGINT,
    allowNull: false,
  
  },
  product_id: {
    type: DataTypes.BIGINT,
    allowNull: false,
  
  },

}, {
  timestamps: false,
  paranoid: true,
  tableName: 'option_product'
});

optionProduct.belongsTo(OptionalMenu , { foreignKey: 'option_id', as: 'options', onDelete: 'CASCADE' });
optionProduct.belongsTo(Product, { foreignKey: 'product_id', as: 'products', onDelete: 'CASCADE' });

module.exports = optionProduct;
