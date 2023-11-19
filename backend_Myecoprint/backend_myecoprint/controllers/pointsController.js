// controllers/pointController.js

const Point = require('../models/Point');
const reasonBarcode = require('../models/reason_barcode');
const Store = require('../models/store');
const User=require('../models/user');
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
  const userId = req.body.user_id;
  const dailyPoints = 50;

  try {

    const user = await User.findOne({ where: { user_id: userId } });

    if (!user) {
      const newUser = await User.create({
        user_id: userId,
        total_points: dailyPoints,
      });

      return res.status(200).json({ message: 'New user created' });
    }

    const now = new Date();
    const today = new Date(now.getUTCFullYear(), now.getUTCMonth(), now.getUTCDate());
    const existingPoint1 = await Point.findOne({
      where: {
        user_id: userId,
        last_daily_point: {
          [Sequelize.Op.gte]: today,
        },
      },
    });

    if (existingPoint1) {
      return res.status(400).json({ error: 'Points already collected today' });
    }

    // Retrieve the existing point data
    const existingPoint = await Point.findOne({ where: { user_id: userId } });

    if (existingPoint) {
      // Update the existing point data
      existingPoint.total_points += dailyPoints;
      existingPoint.last_daily_point = new Date();
      await existingPoint.save();
    } else {
      // Create a new point record
      await Point.create({
        user_id: userId,
        store_id: 4,
        reasonBarcode_id: 1,
        total_points: dailyPoints,
        last_daily_point: new Date(),
      });
    }

    return res.status(200).json({ message: 'Points collected successfully' });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ error: 'Internal server error' });
  }
};

exports.getTotalPointsByUserId = async (req, res) => {


  try {
    const totalPoints = await Point.sum('total_points', {
    
    });
    res.json({ totalPoints });
  } catch (error) {
    res.status(500).json({ error: 'Internal server error', details: error.message });
  }
};