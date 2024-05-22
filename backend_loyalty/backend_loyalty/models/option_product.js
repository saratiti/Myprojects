
const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');
const OptionalMenu = require('./additional_menue');
const Product = require('./product');

const optionProduct = sequelize.define('optionProduct', {
  id: {
    type: DataTypes.BIGINT.UNSIGNED,
    allowNull: false,
    primaryKey: true,
    autoIncrement: true,
  },
  option_id: {
    type: DataTypes.BIGINT.UNSIGNED,
    allowNull: false,

  },
  product_id: {
    type: DataTypes.BIGINT.UNSIGNED,
    allowNull: false,

  },
  created_at: {
    type: DataTypes.DATE,
    allowNull: true,
  },
  updated_at: {
    type: DataTypes.DATE,
    allowNull: true,
  },
}, {
  timestamps: false,
  paranoid: true,
  tableName: 'option_product'
});

optionProduct.belongsTo(OptionalMenu, { foreignKey: 'option_id', as: 'options', onDelete: 'CASCADE' });
optionProduct.belongsTo(Product, { foreignKey: 'product_id', as: 'products', onDelete: 'CASCADE' });

module.exports = optionProduct;
