

const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');
const Category = require('./Category');

const Product = sequelize.define('Product', {
  id: {
    type: DataTypes.BIGINT.UNSIGNED,
    allowNull: false,
    primaryKey: true,
    autoIncrement: true,
  },
  name_ar: {
    type: DataTypes.STRING,
    allowNull: true,
  },
  name_eng: {
    type: DataTypes.STRING,
    allowNull: true,
  },
  product_descrption: {
    type: DataTypes.STRING,
    allowNull: true,
  },
  category_id: {
    type: DataTypes.BIGINT.UNSIGNED,
    allowNull: true,
  },
  quantity: {
    type: DataTypes.INTEGER,
    allowNull: true,
  },
  price: {
    type: DataTypes.DOUBLE,
    allowNull: true,
  },
  image: {
    type: DataTypes.STRING,
    allowNull: true
  },
  // createdAt: {
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
  // }
  created_at: {
    type: DataTypes.DATE,
    allowNull: true,
  },
  updated_at: {
    type: DataTypes.DATE,
    allowNull: true,
  },
  },{
  timestamps: false, 
  paranoid: true,
  tableName: 'products',
  
  });

Product.belongsTo(Category, { foreignKey: 'category_id', as: 'categories', onDelete: 'CASCADE' });

module.exports = Product;
