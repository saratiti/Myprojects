const Category = require('../models/category');
const axios = require('axios');
const multer = require('multer');
const path = require('path');
const fs = require('fs').promises;
const fsread = require('fs');
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, 'uploads/categories');
  },
  filename: (req, file, cb) => {
    cb(null, Date.now() + path.extname(file.originalname)); 
  }
});

const upload = multer({ storage });

// exports.getAllCategories = async (req, res) => {
//   try {
//     const categories = await Category.findAll();
//     res.json(categories);
//   } catch (error) {
//     console.error('Error fetching categories:', error);
//     res.status(500).json({ error: 'Internal server error' });
//   }
// };
 // Import fs with promises




 
 exports.getAllCategories = async (req, res) => {
   try {
     const categories = await Category.findAll();
 
     for (let i = 0; i < categories.length; i++) {
       const category = categories[i];
       const filePath = category.image;
 
       // Construct the full path to the image file
       const fullPath = path.resolve(__dirname, '..', 'uploads', 'categories', filePath);
 
       try {
         // Check if the file exists asynchronously
         await fs.access(fullPath);
         
         // If the file exists, read its content
         const fileContent = await fs.readFile(fullPath);
 
         // Assign the file content to a new property in the category object
         category.file_content = fileContent;
       } catch (error) {
         console.error('File not found:', fullPath);
       }
     }
 
     res.status(200).json({ categories });
   } catch (error) {
     console.error('Error fetching categories:', error.message);
     res.status(500).json({ error: 'Database query error', message: error.message });
   }
 };
 
async function getCategoryImagePath(categoryId) {
  try {
    const category = await Category.findByPk(categoryId);
    if (category) {
      return category.image; 
    } else {
      return null;
    }
  } catch (error) {
    console.error('Error fetching category image path:', error);
    return null;
  }
}

exports.getCategoryImageById = async (req, res) => {
  try {
    const categoryId = req.params.categoryId;
    const imagePath = await getCategoryImagePath(categoryId); 

    if (!imagePath) {
      return res.status(204).send();
    }

    if (!fs.existsSync(imagePath)) {
      return res.status(404).json({ error: 'Category image not found' });
    }

    const image = fs.readFileSync(imagePath);
    const fileExtension = path.extname(imagePath).substr(1);
    let contentType;
    if (fileExtension === 'jpg' || fileExtension === 'jpeg') {
      contentType = 'image/jpeg';
    } else if (fileExtension === 'png') {
      contentType = 'image/png';
    } else {
      contentType = 'image/png';
    }

    res.setHeader('Content-Type', contentType);
    res.status(200).send(image);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Internal server error' });
  }
};


exports.createCategory = (req, res) => {
  upload.single('image')(req, res, async (err) => {
    try {
      if (err instanceof multer.MulterError) {
        console.error('Multer error:', err);
        return res.status(400).json({ error: 'Multer error', message: err.message });
      } else if (err) {
        console.error('Error:', err);
        return res.status(500).json({ error: 'Internal server error', message: err.message });
      }

      const { originalname, filename, path: filePath, mimetype } = req.file;
      const uploadDate = new Date().toISOString();
      const fullPath = path.resolve('uploads/categories', filename);

      const { name_arabic, name_english } = req.body; 

      const newCategory = await Category.create({
        name_arabic,
        name_english,
        image: fullPath,
        created_at: uploadDate,
        updated_at: uploadDate
      });

      res.status(201).json({ message: 'Category created successfully', newCategory });
    } catch (error) {
      console.error('Error creating category:', error.message);
      res.status(500).json({ error: 'Database insertion error', message: error.message });
    }
  });
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
exports.getCategoryImages = async (req, res) => {
  try {
    
    const categories = await Category.findAll();

    if (!categories || categories.length === 0) {
      return res.status(404).json({ error: 'No categories found' });
    }

    const images = [];

    // Iterate through each category
    for (let i = 0; i < categories.length; i++) {
      const category = categories[i];
      const imagePath = category.image;

      if (!imagePath || !fsread.existsSync(imagePath)) {
        // Skip categories with missing or invalid image paths
        console.log(`Skipping category without image: ${category.id}`);
        continue;
      }

      // Read the image file and convert it to base64
      const imageBuffer = fsread.readFileSync(imagePath);
      const base64Image = imageBuffer.toString('base64');

      // Determine the content type based on the file extension
      const contentType = getContentType(path.extname(imagePath).toLowerCase());

      // Construct the data URL
      const dataUrl = `data:${contentType};base64,${base64Image}`;

      // Push the data URL along with the category ID to the images array
      images.push({ categoryId: category.id, dataUrl });
    }

    // Send the images array as a JSON response
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

const retrieveImagesFromDirectory = async (directoryUrl) => {
  try {
    const response = await axios.get(directoryUrl);
    const html = response.data;
    const imageUrls = extractImageUrls(html); 
    const imageUrlsWithType = imageUrls.filter(url => {
      const extension = path.extname(url).toLowerCase();
      return ['.jpg', '.jpeg', '.png', '.gif'].includes(extension);
    });

    console.log('Image URLs:', imageUrlsWithType);
    return imageUrlsWithType;
  } catch (error) {
    console.error('Error retrieving images:', error);
    return [];
  }
};

const retrieveImagesFromServer = async () => {
    const imageUrl = 'https:156.67.73.51/files/public_html/agri/EtaAgri-main%20(1)/public/images/';
    try {
        const response = await axios.get(imageUrl, { responseType: 'arraybuffer' });
        const imageData = Buffer.from(response.data, 'binary').toString('base64');
       
        return imageData;
    } catch (error) {
        console.error('Error retrieving image:', error);
        return null;
    }
};

// exports.getCategoryImages = async (req, res) => {
//   try {
//     const categories = await Category.findAll();

//     if (!categories || categories.length === 0) {
//       return res.status(404).json({ error: 'User not found or no categories found' });
//     }

//     const images = [];

//     for (let i = 0; i < categories.length; i++) {
//       const category = categories[i];
//       const directoryUrl = category.image;
//       const imageUrls = await retrieveImagesFromDirectory(directoryUrl);
//       const imageData = await retrieveImagesFromServer(); 

//       images.push({ categoryId: category.id, imageUrls, imageData });
//     }

//     res.status(200).json({ images });
//   } catch (error) {
//     console.error('Error fetching category images:', error);
//     res.status(500).json({ error: 'Internal server error' });
//   }
// };

// const extractImageUrls = (html) => {
//   const imageUrlRegex = /<img[^>]+src="([^">]+)"/g;
//   const matches = html.matchAll(imageUrlRegex);

//   const imageUrls = [];
//   for (const match of matches) {
//     const imageUrl = match[1];
//     imageUrls.push(imageUrl);
//   }

//   return imageUrls;
// };

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

exports.getImageFromFileServer = async (req, res) => {
  try {
    const { imageName } = req.params;
    const imageUrl = `https://94.156.35.189/var/www/backend_myecoprint/uploads/${imageName}`;
    const response = await axios.get(imageUrl, {
      responseType: 'arraybuffer'
    });
    const ext = imageName.split('.').pop().toLowerCase(); 
    let contentType;
    switch (ext) {
      case 'jpg':
      case 'jpeg':
        contentType = 'image/jpeg';
        break;
      case 'png':
        contentType = 'image/png';
        break;
      case 'gif':
        contentType = 'image/gif';
        break;
      default:
        contentType = 'application/octet-stream';
    }
    res.writeHead(200, { 'Content-Type': contentType });
    res.end(Buffer.from(response.data, 'binary'), 'binary');
  } catch (error) {
    console.error('Error fetching image:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};
