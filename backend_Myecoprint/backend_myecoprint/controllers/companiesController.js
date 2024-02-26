
const Company = require('../models/company');
const fs = require('fs');
const path = require('path');
exports.createCompany = async (req, res) => {
  try {
    const company = await Company.create(req.body);
    res.json(company);
  } catch (error) {
    res.status(400).json({ error: 'Failed to create company', details: error.message });
  }
};

exports.getAllCompanies = async (req, res) => {
  try {
    const companies = await Company.findAll();
    res.json(companies);
  } catch (error) {
    res.status(400).json({ error: 'Failed to fetch company', details: error.message });
  }
};

exports.getCompanyById = async (req, res) => {
  const companyId = req.params.id;

  try {
    const company = await company.findByPk(companyId);
    if (!company) {
      return res.status(404).json({ error: 'company not found' });
    }
    res.json(company);
  } catch (error) {
    res.status(400).json({ error: 'Failed to fetch the company', details: error.message });
  }
};

exports.updateCompany = async (req, res) => {
  const companyId = req.params.id;

  try {
    const [updated] = await Company.update(req.body, {
      where: { company_id: companyId },
    });
    if (!updated) {
      return res.status(404).json({ error: 'Company not found or not updated' });
    }
    const updatedcompany = await Company.findByPk(companyId );
    res.json(updatedcompany);
  } catch (error) {
    res.status(400).json({ error: 'Failed to update the company', details: error.message });
  }
};

exports.deleteCompany = async (req, res) => {
  const companyId = req.params.id;

  try {
    const deleted = await Company.destroy({
      where: { company_id: companyId },
    });
    if (!deleted) {
      return res.status(404).json({ error: 'company not found or not deleted' });
    }
    res.json({ message: 'company deleted successfully' });
  } catch (error) {
    res.status(400).json({ error: 'Failed to delete the company', details: error.message });
  }
};

exports.getCompanyImage = async (req, res) => {
  try {
    const { companyId } = req.params; // Assuming companyId is passed in the URL parameters
    const company = await Company.findOne({ where: { company_id: companyId } });

    if (!company) {
      return res.status(404).json({ error: 'Company not found' });
    }

    // Check if the company has an image
    if (!company.image) {
      return res.status(204).send(); // No image for the company, return without content
    }

    // Check if the file exists
    if (!fs.existsSync(company.image)) {
      return res.status(404).json({ error: 'Company image not found' });
    }

    // Read the image file synchronously
    const image = fs.readFileSync(company.image);

    // Determine the content type based on the file extension
    const fileExtension = path.extname(company.image).substr(1);
    let contentType;
    if (fileExtension === 'jpg' || fileExtension === 'jpeg') {
      contentType = 'image/jpeg';
    } else if (fileExtension === 'png') {
      contentType = 'image/png';
    } else {
      contentType = 'image/png'; // Default to PNG if extension is not recognized
    }

    // Set response headers
    res.setHeader('Content-Type', contentType);

    // Send the image data as response
    res.status(200).send(image);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Internal server error' });
  }
};
