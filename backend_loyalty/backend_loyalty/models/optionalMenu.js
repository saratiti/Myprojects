
const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');
const Product = require('./Product'); 
const OptionalMenu = sequelize.define('OptionalMenu', {
  option_id: {
    type: DataTypes.INTEGER,
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
product_id: {
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
tableName: 'optinoal_menu',

});
OptionalMenu.belongsTo(Product, { foreignKey: 'product_id', as: 'products', onDelete: 'CASCADE'  });

module.exports = OptionalMenu;
