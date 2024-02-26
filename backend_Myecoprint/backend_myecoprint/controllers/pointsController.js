// controllers/pointController.js

const Point = require('../models/Point');
const reasonBarcode = require('../models/reason_barcode');
const Store = require('../models/store');
const User=require('../models/user');
const Transaction=require('../models/transaction');
const Sequelize = require('sequelize');

exports.createPoint = async (req, res) => {
  try {
    const point = await Point.create(req.body);
    res.json(point);
  } catch (error) {
    res.status(400).json({ error: 'Failed to create Point', details: error.message });
  }
};


exports.getAllPoints = async (req, res) => {
  try {
    const points = await Point.findAll({
        include: [
          { model: Store, as: 'stores' },
          { model: reasonBarcode, as: 'reason_barcodes' },
        ]
      });
    res.json(points);
  } catch (error) {
    res.status(400).json({ error: 'Failed to fetch Points', details: error.message });
  }
};

exports.getPointById = async (req, res) => {
  const pointId = req.params.id;

  try {
    const point = await Point.findByPk(pointId);
    if (!point) {
      return res.status(404).json({ error: 'Point not found' });
    }
    res.json(point);
  } catch (error) {
    res.status(400).json({ error: 'Failed to fetch the Point', details: error.message });
  }
};

exports.updatePoint = async (req, res) => {
  const pointId = req.params.id;

  try {
    const [updated] = await Point.update(req.body, {
      where: { point_id: pointId },
    });
    if (!updated) {
      return res.status(404).json({ error: 'Point not found or not updated' });
    }
    const updatedPoint = await Point.findByPk(pointId);
    res.json(updatedPoint);
  } catch (error) {
    res.status(400).json({ error: 'Failed to update the Point', details: error.message });
  }
};

exports.deletePoint = async (req, res) => {
  const pointId = req.params.id;

  try {
    const deleted = await Point.destroy({
      where: { point_id: pointId },
    });
    if (!deleted) {
      return res.status(404).json({ error: 'Point not found or not deleted' });
    }
    res.json({ message: 'Point deleted successfully' });
  } catch (error) {
    res.status(400).json({ error: 'Failed to delete the Point', details: error.message });
  }
};


exports.collectDaily = async (req, res) => {
  const user = req.user;

  if (!user) {
    return res.status(401).json({ error: 'Unauthorized' });
  }

  const dailyPoints = 50;

  try {

    let existingPoint = await Point.findOne({
      where: {
        user_id: user.user_id,
      },
    });

    if (existingPoint) {
      const now = new Date();
      const today = new Date(now.getUTCFullYear(), now.getUTCMonth(), now.getUTCDate());

      if (existingPoint.last_daily_point >= today) {
        return res.status(400).json({ error: 'Points already collected today' });
      }
      existingPoint.total_points += dailyPoints;
      existingPoint.last_daily_point = new Date();
      await existingPoint.save();
    } else {
  
      existingPoint = await Point.create({
        user_id: user.user_id,
        store_id: 4,
        reasonBarcode_id: 1,
        total_points: dailyPoints,
        last_daily_point: new Date(),
      });
    }


    await Transaction.create({
      user_id: user.user_id,
      store_id: 4,
      points: dailyPoints,
      transaction_type: 'daily_points',
      transaction_date: new Date(),
    });

    return res.status(200).json({ message: 'Points collected successfully', dailyPoints });

  } catch (error) {
    console.error(error);
    return res.status(500).json({ error: 'Internal server error' });
  }
};



exports.getTotalPointsByUserId = async (req, res, next) => {
  try {

    const userId = req.user ? req.user.user_id : req;
    if (req.user && !res) {
      console.error('Response object is undefined.');
      return;
    }

    const totalPoints = await Point.findOne({
      attributes: ['total_points'],
      where: { user_id: userId }
    });

    if (req.user) {
      return res.status(200).json({ message: 'Total_Points', totalPoints });
    }

    return totalPoints ? totalPoints.total_points : 0

  } catch (error) {
    console.error('Error in getTotalPointsByUserId:', error);

    if (res) {
      return res.status(500).json({ error: 'Internal server error', details: error.message });
    } else {
      console.error('Response object is undefined.');
      throw error;
    }
  }
};

