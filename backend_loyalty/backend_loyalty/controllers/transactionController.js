

const Transaction = require('../models/transaction');
const User=require('../models/user');
const moment = require('moment');
const sequelize = require('../config/database');
const { Op } = require('sequelize');


exports.getTransactionWeekly = async (req, res) => {
  try {
    const userId = req.user_id;
    
    const user = await User.findByPk(userId);
    if (!user) {
      return res.status(404).json({ error: 'User not found' });
    } 

    
    const startDate = moment().startOf('week').toDate(); 
    const endDate = moment().endOf('week').toDate(); 

    const transactions = await Transaction.findAll({
      where: {
        user_id: userId,
        transaction_date: {
          [Op.between]: [startDate, endDate]
        }
      }
    });

    res.json(transactions);
  } catch (error) {
    console.error('Error retrieving transactions:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};



exports.getAllTransactionsByUser = async (req, res) => {
    try {
        const userId = req.user_id;
    
       
        const user = await User.findByPk(userId);
        if (!user) {
          return res.status(404).json({ error: 'User not found' });
        } 
        const transactions = await Transaction.findAll({
          where: { user_id: userId },
          order: [['transaction_date','desc']],
        });
    
        res.status(200).json({ transactions });
      } catch (error) {
        console.error('Error in getAllTransactionsByUser controller:', error);
        return res.status(500).json({ error: 'Internal server error' });
      }

  };

  exports.getFilteredTransaction = async (req, res) => {
    try {
      const { sort } = req.params;
      const sortOrder = sort === 'desc' ? 'desc' : 'asc';
  
      const transactions = await Transaction.findAll();
      let sortedTransactions;
  
      if (sortOrder === 'asc') {
        sortedTransactions = transactions.sort((a, b) => (a.transaction_date > b.transaction_date ? 1 : -1));
      } else {
        sortedTransactions = transactions.sort((a, b) => (a.transaction_date > b.transaction_date ? -1 : 1));
      }
  
      res.json(sortedTransactions);
    } catch (error) {
      console.error('Error retrieving and sorting transactions:', error);
      res.status(500).json({ error: 'Internal server error' });
    }
  };
  
  
  
  
  