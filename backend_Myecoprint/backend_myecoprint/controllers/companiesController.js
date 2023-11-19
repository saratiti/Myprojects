
const Company = require('../models/company');

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
