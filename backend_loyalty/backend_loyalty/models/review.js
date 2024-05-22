

const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');
const User = require('./user'); 
const Product = require('./product'); 

const Review = sequelize.define('Review', {
  id: {
    type: DataTypes.BIGINT.UNSIGNED,
    allowNull: false,
    primaryKey: true,
    autoIncrement: true,
  },
  rating: {
    type: DataTypes.DOUBLE,
    allowNull: true,
  },
  comment: {
    type: DataTypes.STRING,
    allowNull: true,
  },
  user_id: {
    type: DataTypes.BIGINT.UNSIGNED,
    
  },
  product_id: {
    type: DataTypes.BIGINT.UNSIGNED,
    
  },
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
  // }
  },{
  timestamps: false, 
  paranoid: true,
  tableName: 'reviews',
  
  });

Review.belongsTo(User, { foreignKey: 'user_id', as: 'users',key: 'id', onDelete: 'CASCADE' });
Review.belongsTo(Product, { foreignKey: 'product_id', as: 'products',key: 'id', onDelete: 'CASCADE'  });

module.exports = Review;
