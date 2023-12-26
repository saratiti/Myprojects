
const Branche = require('../models/branche');
const Store = require('../models/store');

exports.createBranche = async (req, res) => {
  try {
    const branche = await Branche.create(req.body);
    res.json(branche);
  } catch (error) {
    res.status(400).json({ error: 'Failed to create branche', details: error.message });
  }
};

exports.getAllBranches = async (req, res) => {
  try {
    const branches = await Branche.findAll({
      include: [
        { model: Store, as: 'stores' },
       
      ]
    });

    res.json(branches);
  } catch (error) {
    res.status(400).json({ error: 'Failed to fetch branche', details: error.message });
  }
};

exports.getBrancheById = async (req, res) => {
  const brancheId = req.params.id;

  try {
    const branche = await Branche .findByPk(brancheId);
    if (!branche) {
      return res.status(404).json({ error: 'branche not found' });
    }
    res.json(branche);
  } catch (error) {
    res.status(400).json({ error: 'Failed to fetch the branche', details: error.message });
  }
};

exports.updateBranche = async (req, res) => {
  const brancheId = req.params.id;

  try {
    const [updated] = await Branche .update(req.body, {
      where: { branche_id: brancheId },
    });
    if (!updated) {
      return res.status(404).json({ error: 'branche not found or not updated' });
    }
    const updatedBranche = await Branche .findByPk(brancheId );
    res.json(updatedBranche);
  } catch (error) {
    res.status(400).json({ error: 'Failed to update the branche', details: error.message });
  }
};

exports.deleteBranche = async (req, res) => {
  const brancheId = req.params.id;

  try {
    const deleted = await Branche.destroy({
      where: { branche_id: brancheId },
    });
    if (!deleted) {
      return res.status(404).json({ error: 'branche not found or not deleted' });
    }
    res.json({ message:'branche deleted successfully' });
  } catch (error) {
    res.status(400).json({ error: 'Failed to delete the branche', details: error.message });
  }
};
