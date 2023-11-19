
const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');
const Store= require('./store');

const Contact = sequelize.define('Contact ', {
    contact_id: {
        type: DataTypes.INTEGER,
        allowNull: false,
        primaryKey: true,
        autoIncrement: true,
    },
    store_id: {
        type: DataTypes.INTEGER,
        allowNull: false,
    },

    phone_number: {
        type: DataTypes.STRING,
    },
    branch: {
        type: DataTypes.STRING,
        allowNull: false,
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
    },
}, {
    timestamps: false, 
    paranoid: true, 
    tableName: 'contcats', 
  });
  Contact.belongsTo(Store, { foreignKey: 'store_id', as: 'stores',onDelete: 'CASCADE' });
module.exports =Contact;

































