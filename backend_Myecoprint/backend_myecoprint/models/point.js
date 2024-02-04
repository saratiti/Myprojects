
const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');
const reasonBarcode = require('./reason_barcode');
const User=require('./user')
const Store= require('./store');
const Point = sequelize.define('Point', {
    point_id: {
    type: DataTypes.INTEGER,
    allowNull: false,
    primaryKey: true,
    autoIncrement: true,
  },
  
store_id: {
    type: DataTypes.INTEGER,
    
  },
 last_daily_point:{
 type:DataTypes.DATE

 },
  total_points: {
    type: DataTypes.NUMBER,
  },
  reasonBarcode_id: {
    type: DataTypes.INTEGER,
  
  },
  user_id: {
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
  },
}, {
    timestamps: false, 
    paranoid: true, 
    tableName: 'points', 
  });
  Point.belongsTo(User, { foreignKey: 'user_id', as: 'users',onDelete: 'CASCADE' });
  Point.belongsTo(Store, { foreignKey: 'store_id', as: 'stores',onDelete: 'CASCADE' });
  Point .belongsTo(reasonBarcode, { foreignKey: 'reasonBarcode_id', as: 'reason_barcodes',onDelete: 'CASCADE' });

module.exports = Point;


























