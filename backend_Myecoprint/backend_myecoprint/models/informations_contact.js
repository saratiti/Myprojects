
const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');
const Store= require('./store');
const informationContact = sequelize.define('informationContact ', {
    info_contact_id: {
        type: DataTypes.INTEGER,
        allowNull: false,
        primaryKey: true,
        autoIncrement: true,
    },
    store_id: {
        type: DataTypes.INTEGER,
        allowNull: false,
    },

    email: {
        type: DataTypes.STRING,
    },
    land_phone: {
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
    tableName: 'informations_contacts', 
  });
  informationContact.belongsTo(Store, { foreignKey: 'store_id', as: 'stores' });
module.exports = informationContact;































