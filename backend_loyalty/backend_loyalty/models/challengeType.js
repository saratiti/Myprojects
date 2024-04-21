
const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const ChallengeType = sequelize.define('ChallengeType ', {

  challengType_id: {
    type: DataTypes.BIGINT,
    primaryKey: true,
    autoIncrement: true
  },
  type_name: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  required_count: {
    type: DataTypes.INTEGER,
    allowNull: false,
  },
  points: {
    type: DataTypes.INTEGER,
    allowNull: false
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
  tableName: 'challenge_types',
});

module.exports = ChallengeType;
