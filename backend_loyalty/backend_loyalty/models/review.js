

const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');
const User = require('./User'); 
const Product = require('./Product'); 

const Review = sequelize.define('Review', {
  review_id: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true
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
    type: DataTypes.INTEGER,
    
  },
  product_id: {
    type: DataTypes.INTEGER,
    
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
  }
  },{
  timestamps: false, 
  paranoid: true,
  tableName: 'reviews',
  
  });

Review.belongsTo(User, { foreignKey: 'user_id', as: 'users', onDelete: 'CASCADE' });
Review.belongsTo(Product, { foreignKey: 'product_id', as: 'products', onDelete: 'CASCADE'  });

module.exports = Review;
