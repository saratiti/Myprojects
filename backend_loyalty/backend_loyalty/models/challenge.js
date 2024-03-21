

const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const Challenge = sequelize.define('Challenge', {

  challeng_id: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true
  },
  challenge_name: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  challenge_description: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  challenge_type: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  value: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  reward_point: {
    type: DataTypes.INTEGER,
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
  }

}, {
  timestamps: false, 
  paranoid: true,
  tableName: 'challenges',
});

module.exports = Challenge;
