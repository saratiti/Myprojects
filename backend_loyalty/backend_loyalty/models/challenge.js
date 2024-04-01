

const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');
const ChallengeType = require('./challengeType'); 

const Challenge = sequelize.define('Challenge', {

  challenge_id: {
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
  challengType_id:{
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
Challenge.belongsTo(ChallengeType, { foreignKey: 'challengType_id', as: 'challengeTypes', onDelete: 'CASCADE' });

module.exports = Challenge;
