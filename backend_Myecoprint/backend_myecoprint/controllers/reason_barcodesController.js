// controllers/reasonBarcodeController.js

const reasonBarcode = require('../models/reason_barcode');


exports.createreasonBarcode = async (req, res) => {
  try {
    const reason_Barcode = await reasonBarcode.create(req.body);
    res.json(reason_Barcode);
  } catch (error) {
    res.status(400).json({ error: 'Failed to create reasonBarcode', details: error.message });
  }
};


exports.getAllreasonBarcodes = async (req, res) => {
  try {
    const reason_Barcodes = await reasonBarcode.findAll();
    res.json(reason_Barcodes);
  } catch (error) {
    res.status(400).json({ error: 'Failed to fetch reasonBarcodes', details: error.message });
  }
};

exports.getreasonBarcodeById = async (req, res) => {
  const reasonBarcodeId = req.params.id;

  try {
    const reason_Barcode = await reasonBarcode.findByPk(reasonBarcodeId);
    if (!reason_Barcode) {
      return res.status(404).json({ error: 'reasonBarcode not found' });
    }
    res.json(reason_Barcode);
  } catch (error) {
    res.status(400).json({ error: 'Failed to fetch the reasonBarcode', details: error.message });
  }
};

exports.updatereasonBarcode = async (req, res) => {
  const reasonBarcodeId = req.params.id;

  try {
    const [updated] = await reasonBarcode.update(req.body, {
      where: { reasonBarcode_id: reasonBarcodeId },
    });
    if (!updated) {
      return res.status(404).json({ error: 'reasonBarcode not found or not updated' });
    }
    const updatedreasonBarcode = await reasonBarcode.findByPk(reasonBarcodeId);
    res.json(updatedreasonBarcode);
  } catch (error) {
    res.status(400).json({ error: 'Failed to update the reasonBarcode', details: error.message });
  }
};

exports.deletereasonBarcode = async (req, res) => {
  const reasonBarcodeId = req.params.id;

  try {
    const deleted = await reasonBarcode.destroy({
      where: { reasonBarcode_id: reasonBarcodeId },
    });
    if (!deleted) {
      return res.status(404).json({ error: 'reasonBarcode not found or not deleted' });
    }
    res.json({ message: 'reasonBarcode deleted successfully' });
  } catch (error) {
    res.status(400).json({ error: 'Failed to delete the reasonBarcode', details: error.message });
  }
};
