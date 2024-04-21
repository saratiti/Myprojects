
const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');
const OptionalMenu = sequelize.define('OptionalMenu', {
  option_id: {
    type: DataTypes.BIGINT,
    primaryKey: true,
    autoIncrement: true
  },
  name_arabic: {
    type: DataTypes.STRING,
    allowNull: true,
  },
  name_english: {
    type: DataTypes.STRING,
    allowNull: true,
  },
  price: {
    type: DataTypes.DOUBLE,
    allowNull: true,
  
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
tableName: 'optinoal_menu',

});

module.exports = OptionalMenu;
