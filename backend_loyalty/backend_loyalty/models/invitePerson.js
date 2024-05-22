
const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');
const User = require('./User');

const InvitePerson = sequelize.define('InvitePerson', {
  id: {
    type: DataTypes.BIGINT.UNSIGNED,
    allowNull: false,
    primaryKey: true,
    autoIncrement: true,
  },
  status: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  invite_email: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  invite_date: {
    type: DataTypes.DATE,
    allowNull: false,
  },
  user_id: {
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
deletedAt: {
  type: DataTypes.DATE,
  allowNull: true,
}
},{
timestamps: false, 
paranoid: true,
tableName: 'invite_person',

});

InvitePerson.belongsTo(User, { foreignKey: 'user_id', as: 'users', onDelete: 'CASCADE' });

module.exports = InvitePerson;
