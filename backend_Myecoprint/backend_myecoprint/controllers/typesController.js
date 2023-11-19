

const Type = require('../models/type');


exports.createType = async (req, res) => {
  try {
    const type = await Type.create(req.body);
    res.json(type);
  } catch (error) {
    res.status(400).json({ error: 'Failed to create Type', details: error.message });
  }
};


exports.getAllTypes = async (req, res) => {
  try {
    const types = await Type.findAll();
    res.json(types);
  } catch (error) {
    res.status(400).json({ error: 'Failed to fetch Types', details: error.message });
  }
};

exports.getTypeById = async (req, res) => {
  const typeId = req.params.id;

  try {
    const type = await Type.findByPk(typeId);
    if (!type) {
      return res.status(404).json({ error: 'Type not found' });
    }
    res.json(type);
  } catch (error) {
    res.status(400).json({ error: 'Failed to fetch the Type', details: error.message });
  }
};

exports.updateType = async (req, res) => {
  const typeId = req.params.id;

  try {
    const [updated] = await Type.update(req.body, {
      where: { type_id: typeId },
    });
    if (!updated) {
      return res.status(404).json({ error: 'Type not found or not updated' });
    }
    const updatedType = await Type.findByPk(typeId);
    res.json(updatedType);
  } catch (error) {
    res.status(400).json({ error: 'Failed to update the Type', details: error.message });
  }
};

exports.deleteType = async (req, res) => {
  const typeId = req.params.id;

  try {
    const deleted = await Type.destroy({
      where: { type_id: typeId },
    });
    if (!deleted) {
      return res.status(404).json({ error: 'Type not found or not deleted' });
    }
    res.json({ message: 'Type deleted successfully' });
  } catch (error) {
    res.status(400).json({ error: 'Failed to delete the Type', details: error.message });
  }
};

