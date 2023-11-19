
const Contcat = require('../models/contcat');
const Store = require('../models/store');

exports.createContcat = async (req, res) => {
  try {
    const contcat = await contcat.create(req.body);
    res.json(contcat);
  } catch (error) {
    res.status(400).json({ error: 'Failed to create contcat', details: error.message });
  }
};

exports.getAllContcats = async (req, res) => {
  try {
    const contcats = await Contcat.findAll({
        include: [
          { model: Store, as: 'stores' },
         
        ]
      });
    res.json(contcats);
  } catch (error) {
    res.status(400).json({ error: 'Failed to fetch contcat', details: error.message });
  }
};

exports.getContatById = async (req, res) => {
  const contcatId = req.params.id;

  try {
    const contcat = await Contcat.findByPk(contcatId);
    if (!contcat) {
      return res.status(404).json({ error: 'contcat not found' });
    }
    res.json(contcat);
  } catch (error) {
    res.status(400).json({ error: 'Failed to fetch the contcat', details: error.message });
  }
};

exports.updateContcat = async (req, res) => {
  const contcatId = req.params.id;

  try {
    const [updated] = await Contcat.update(req.body, {
      where: { contcat_id: contcatId },
    });
    if (!updated) {
      return res.status(404).json({ error: 'contcat not found or not updated' });
    }
    const updatedcontcat = await Contcat.findByPk(contcatId );
    res.json(updatedcontcat);
  } catch (error) {
    res.status(400).json({ error: 'Failed to update the contcat', details: error.message });
  }
};

exports.deleteContcat = async (req, res) => {
  const contcatId = req.params.id;

  try {
    const deleted = await Contcat.destroy({
      where: { contcat_id: contcatId },
    });
    if (!deleted) {
      return res.status(404).json({ error: 'contcat not found or not deleted' });
    }
    res.json({ message: 'contcat deleted successfully' });
  } catch (error) {
    res.status(400).json({ error: 'Failed to delete the contcat', details: error.message });
  }
};
