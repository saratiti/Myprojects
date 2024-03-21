
const Invoice = require('../models/invoice');

exports.getAllInvoices = async (req, res) => {
  try {
    const invoices = await Invoice.findAll();
    res.json(invoices);
  } catch (error) {
    console.error('Error retrieving invoices:', error.message);
    res.status(500).send('Server Error');
  }
};

exports.createInvoice = async (req, res) => {
  try {
    const newInvoice = await Invoice.create(req.body);
    res.status(201).json({ message: 'Invoice created successfully', newInvoice });
  } catch (error) {
    console.error('Error creating invoice:', error.message);
    res.status(500).send('Server Error');
  }
};
