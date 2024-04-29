
const Category = require('../models/category');

const fs = require('fs');
const path = require('path');
exports.getAllCategories = async (req, res) => {
  try {
    const categories = await Category.findAll();
    res.json(categories);
  } catch (error) {
    console.error('Error fetching categories:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};


exports.createCategory = async (req, res) => {
  try {
    const { name_arabic, name_english, image } = req.body;
    const category = await Category.create({ name_arabic, name_english, image });
    res.status(201).json(category);
  } catch (error) {
    console.error('Error creating category:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};


exports.updateCategory = async (req, res) => {
  try {
    const { id } = req.params;
    const { name_arabic, name_english, image } = req.body;
    const category = await Category.findByPk(id);
    if (!category) {
      return res.status(404).json({ error: 'Category not found' });
    }
    await category.update({ name_arabic, name_english, image });
    res.json(category);
  } catch (error) {
    console.error('Error updating category:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};


exports.deleteCategory = async (req, res) => {
  try {
    const { id } = req.params;
    const category = await Category.findByPk(id);
    if (!category) {
      return res.status(404).json({ error: 'Category not found' });
    }
    await category.destroy();
    res.json({ message: 'Category deleted successfully' });
  } catch (error) {
    console.error('Error deleting category:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};




exports.getCategoryImages = async (req, res) => {
  try {
    const categories = await Category.findAll();

    if (!categories || categories.length === 0) {
      return res.status(404).json({ error: 'User not found or no categories found' });
    }

    const images = [];

    for (let i = 0; i < categories.length; i++) {
      const category = categories[i];
      const imagePath = category.image;

      console.log(`Checking image path: ${imagePath}`); // Debug print

      if (!imagePath || !fs.existsSync(imagePath)) {
        console.log(`Image not found: ${imagePath}`); // Debug print
        continue;
      }

      const imageExtensions = ['.jpg', '.jpeg', '.png', '.gif'];
      const ext = path.extname(imagePath).toLowerCase();
      if (!imageExtensions.includes(ext)) {
        console.log(`Skipping non-image file: ${imagePath}`); // Debug print
        continue;
      }

      const imageBuffer = fs.readFileSync(imagePath);
      const base64Image = imageBuffer.toString('base64');
      const contentType = getContentType(ext);
      const dataUrl = `data:${contentType};base64,${base64Image}`;

      images.push({ categoryId: category.id, dataUrl });
    }

    res.status(200).json({ images });
  } catch (error) {
    console.error('Error fetching category images:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};


function getContentType(fileExtension) {
  switch (fileExtension) {
    case '.jpg':
    case '.jpeg':
      return 'image/jpeg';
    case '.png':
      return 'image/png';
      
    case '.gif':
      return 'image/gif';
    default:
      return 'application/octet-stream';
  }
}
