

const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');
const User = require('./User'); 

const Loyalty = sequelize.define('Loyalty', {
  loyality_id: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true
  },
  loyalty_point: {
    type: DataTypes.INTEGER,
    allowNull: true,
  },
  loyalty_level: {
    type: DataTypes.STRING,
    allowNull: true,
  },
  last_activity_date: {
    type: DataTypes.DATE,
    allowNull: true,

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
}
},{
timestamps: false, 
paranoid: true,
tableName: 'loyalities',

});

Loyalty.belongsTo(User, { foreignKey: 'user_id', as: 'users', onDelete: 'CASCADE' });

module.exports = Loyalty;
