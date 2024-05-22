

const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');
const User = require('./User'); 

const Order = sequelize.define('Order', {
  id: {
    type: DataTypes.BIGINT.UNSIGNED,
    allowNull: false,
    primaryKey: true,
    autoIncrement: true,
  },
  total_price: {
    type: DataTypes.DOUBLE,
    allowNull: true,
  },
  sub_total: {
    type: DataTypes.DOUBLE,
    allowNull: true,
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
// deletedAt: {
//   type: DataTypes.DATE,
//   allowNull: true,
// }
},{
timestamps: false, 
paranoid: true,
tableName: 'orders',

});


Order.belongsTo(User, { foreignKey: 'user_id', as: 'users', key: 'id', onDelete: 'CASCADE' });

module.exports = Order;
