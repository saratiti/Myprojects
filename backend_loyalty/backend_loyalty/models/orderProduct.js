

const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');
const Order = require('./Order'); 
const Product = require('./Product'); 

const OrderProduct = sequelize.define('OrderProduct', {
  order_product_id: {
    type: DataTypes.BIGINT,
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
    type: DataTypes.BIGINT,
    
  },
  order_id: {
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
tableName: 'order_products',

});

OrderProduct.belongsTo(Order, { foreignKey: 'order_id', as: 'orders',key: 'order_id', onDelete: 'CASCADE' });
OrderProduct.belongsTo(Product, { foreignKey: 'product_id', as: 'products',key: 'id', onDelete: 'CASCADE' });

module.exports = OrderProduct;
