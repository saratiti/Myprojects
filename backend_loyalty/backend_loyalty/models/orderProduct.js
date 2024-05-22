

const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');
const Order = require('./Order'); 
const Product = require('./Product'); 

const OrderProduct = sequelize.define('OrderProduct', {
 id: {
  type: DataTypes.BIGINT.UNSIGNED,
    primaryKey: true,
    autoIncrement: true
  },
  qty: {
    type: DataTypes.INTEGER,
    allowNull: true,
  },
  price: {
    type: DataTypes.DOUBLE,
    allowNull: true,
  },
  product_id: {
    type: DataTypes.BIGINT.UNSIGNED,
    
  },
  order_id: {
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
tableName: 'order_product',

});

OrderProduct.belongsTo(Order, { foreignKey: 'order_id', as: 'orders',key: 'id', onDelete: 'CASCADE' });
OrderProduct.belongsTo(Product, { foreignKey: 'product_id', as: 'products',key: 'id', onDelete: 'CASCADE' });

module.exports = OrderProduct;
