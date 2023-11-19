// PointRedemption.js

const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');
const User = require('./user');
const Store = require('./store');
const Offer = require('./offer'); // Import the Offer model

const PointRedemption = sequelize.define('PointRedemption', {
  redemption_id: {
    type: DataTypes.INTEGER,
    allowNull: false,
    primaryKey: true,
    autoIncrement: true,
  },
  user_id: {
    type: DataTypes.INTEGER,
    allowNull: false,
  },
  store_id: {
    type: DataTypes.INTEGER,
    allowNull: false,
  },
  offer_id: { // Add the foreign key to the Offer table
    type: DataTypes.INTEGER,
    allowNull: false,
  },
  points_redeemed: {
    type: DataTypes.INTEGER,
    allowNull: false,
  },
  redemption_date: {
    type: DataTypes.DATE,
    allowNull: false,
  },
}, {
  timestamps: false,
  tableName: 'point_redemptions',
});

PointRedemption.belongsTo(User, { foreignKey: 'user_id', as: 'users', onDelete: 'CASCADE' });
PointRedemption.belongsTo(Store, { foreignKey: 'store_id', as: 'stores', onDelete: 'CASCADE' });
PointRedemption.belongsTo(Offer, { foreignKey: 'offer_id', as: 'offers', onDelete: 'CASCADE' }); // Add the association

module.exports = PointRedemption;
