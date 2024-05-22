const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');
const ChallengeType = require('./challengeType');

const Challenge = sequelize.define('Challenge', {
  id: {
    type: DataTypes.BIGINT.UNSIGNED,
    allowNull: false,
    primaryKey: true,
    autoIncrement: true,
  },
  challenge_name: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  challenge_description: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  challengType_id: {
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
