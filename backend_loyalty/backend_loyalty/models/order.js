

const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');
const User = require('./User'); 

const Order = sequelize.define('Order', {
  order_id: {
    type: DataTypes.BIGINT,
    primaryKey: true,
    autoIncrement: true
  },
  total_price: {
    type: DataTypes.DOUBLE,
    allowNull: true,
  },
  sub_total: {
    type: DataTypes.DOUBLE,
    allowNull: true,
  },
  tax_amount: {
    type: DataTypes.DOUBLE,
    allowNull: true,
  },
  total: {
    type: DataTypes.STRING,
    allowNull: true,
  },
  payment_method_type: {
    type: DataTypes.STRING,
    allowNull: true,
  
},
user_id: {
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
tableName: 'orders',

});


Order.belongsTo(User, { foreignKey: 'user_id', as: 'users', key: 'id', onDelete: 'CASCADE' });

module.exports = Order;
