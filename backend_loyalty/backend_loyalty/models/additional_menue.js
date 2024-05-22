
const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');
const additionalMenues = sequelize.define('OptionalMenu', {
  id: {
    type: DataTypes.BIGINT.UNSIGNED,
    allowNull: false,
    primaryKey: true,
    autoIncrement: true,
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


created_at: {
  type: DataTypes.DATE,
  allowNull: true,
},
updated_at: {
  type: DataTypes.DATE,
  allowNull: true,
},

},{
timestamps: false, 
paranoid: true,
tableName: 'additional_menues',

});

module.exports = additionalMenues;
