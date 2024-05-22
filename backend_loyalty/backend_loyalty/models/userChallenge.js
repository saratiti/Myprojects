const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');
const User = require('./user'); 
const Challenge = require('./challenge'); 

const UserChallenge = sequelize.define('UserChallenge', {
  id: {
    type: DataTypes.BIGINT.UNSIGNED,
    primaryKey: true,
    autoIncrement: true
  },
  status: {
    type: DataTypes.STRING,
    allowNull: true,
  },
  complete_date: {
    type: DataTypes.DATE,
    allowNull: true,
  },
  user_id: {
    type: DataTypes.BIGINT.UNSIGNED,
    references: {
      model: 'users',
      key: 'id'
    }
  },
  challenge_id: {
    type: DataTypes.BIGINT.UNSIGNED,
    references: {
      model: 'challenges', 
      key: 'id'
    }
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
  tableName: 'user_challenges',
});

UserChallenge.belongsTo(User, { foreignKey: 'user_id', as: 'users', onDelete: 'CASCADE' });
UserChallenge.belongsTo(Challenge, { foreignKey: 'challenge_id', as: 'challenges', onDelete: 'CASCADE' });

module.exports = UserChallenge;
