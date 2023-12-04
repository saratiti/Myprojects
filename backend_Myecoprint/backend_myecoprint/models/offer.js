
const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');
const Company = require('./company');

const Offer = sequelize.define('Offer', {
    offer_id: {
        type: DataTypes.INTEGER,
        allowNull: false,
        primaryKey: true,
        autoIncrement: true,
    },

    company_id: {
        type: DataTypes.INTEGER,
        allowNull: false,
    },

    offer_name_arabic: {
        type: DataTypes.STRING,
    },
    offer_name_english: {
        type: DataTypes.STRING,
        allowNull: false,
    },

    offer_description: {
        type: DataTypes.STRING,
        allowNull: false,
    },
    number_point: {
        type: DataTypes.INTEGER,
        allowNull: false,
    },
    number_discount: {
        type: DataTypes.DOUBLE,
        allowNull: false,
    },
    offer_start_date: {
        type: DataTypes.DATE,
        allowNull: false,
    },
    offer_end_date: {
        type: DataTypes.DATE,
        allowNull: false,
    },

    offer_discount: {
        type: DataTypes.DOUBLE,
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
    tableName: 'offers', 
  });
  Offer.belongsTo(Company, { foreignKey: 'company_id', as: 'companies',onDelete: 'CASCADE' });
module.exports = Offer;































