
const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');
const Company = require('./company');
const Store = require('./store');

const Offer = sequelize.define('Offer', {
    offer_id: {
        type: DataTypes.INTEGER,
        allowNull: false,
        primaryKey: true,
        autoIncrement: true,
    },

    company_id: {
        type: DataTypes.INTEGER,
        
    },
    store_id: {
        type: DataTypes.INTEGER,
       
    },
  
    offer_name_arabic: {
        type: DataTypes.STRING,
    },
    offer_name_english: {
        type: DataTypes.STRING,
       
    },

    offer_description: {
        type: DataTypes.STRING,
       
    },
    number_point: {
        type: DataTypes.INTEGER,
       
    },
    number_discount: {
        type: DataTypes.DOUBLE,
        
    },
    offer_start_date: {
        type: DataTypes.DATE,
       
    },
    offer_end_date: {
        type: DataTypes.DATE,
       
    },

    offer_discount: {
        type: DataTypes.DOUBLE,
        
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
  Offer.belongsTo(Company, { foreignKey: 'company_id', as: 'companies', onDelete: 'CASCADE' });
  Offer.belongsTo(Store, { foreignKey: 'store_id', as: 'stores', onDelete: 'CASCADE' });
  
module.exports = Offer;































