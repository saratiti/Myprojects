
const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');
const User = require('./User'); 
const Challenge = require('./Challenge'); 

const UserChallenge = sequelize.define('UserChallenge', {
  user_challenge_id: {
    type: DataTypes.BIGINT,
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
    type: DataTypes.BIGINT,
    
  },
  challenge_id: {
    type: DataTypes.BIGINT,
    
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
    tableName: 'user_challenges',
    
    });

UserChallenge.belongsTo(User, { foreignKey: 'user_id', as: 'users', onDelete: 'CASCADE' });
UserChallenge.belongsTo(Challenge, { foreignKey: 'challenge_id', as:'challenges',onDelete: 'CASCADE' });

module.exports = UserChallenge;

