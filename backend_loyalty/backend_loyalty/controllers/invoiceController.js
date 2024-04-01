const Invoice = require('../models/invoice');
const multer = require('multer');

const fs = require('fs');
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, 'uploads/');
  },
  filename: (req, file, cb) => {
    cb(null, Date.now() + path.extname(file.originalname)); 
  }
});

const upload = multer({ storage });


const path = require('path');

exports.createInvoice = (req, res) => {
  upload.single('invoice')(req, res, async (err) => {
    try {
      if (err instanceof multer.MulterError) {
        console.error('Multer error:', err);
        return res.status(400).json({ error: 'Multer error', message: err.message });
      } else if (err) {
        console.error('Error:', err);
        return res.status(500).json({ error: 'Internal server error', message: err.message });
      }

      const userId = req.user.user_id; 
      const { originalname, filename, path: filePath, mimetype } = req.file;
      const uploadDate = new Date().toISOString();

      // Resolve the absolute path
      const fullPath = path.resolve(filePath);

      const newInvoice = await Invoice.create({
        user_id: userId,
        file_name: filename,
        file_path: fullPath, // Use the resolved full path
        file_original_name: originalname,
        file_mime_type: mimetype,
        upload_date: uploadDate
      });

      res.status(201).json({ message: 'Invoice created successfully', newInvoice });
    } catch (error) {
      console.error('Error creating invoice:', error.message);
      res.status(500).json({ error: 'Database insertion error', message: error.message });
    }
  });
};

exports.getAllInvoicesByUserId = async (req, res) => {
  try {
    const userId = req.user.user_id; 
    const invoices = await Invoice.findAll({ where: { user_id: userId } });

    // Read file contents for each invoice
    for (let i = 0; i < invoices.length; i++) {
      const invoice = invoices[i];
      const filePath = invoice.file_path;

      // Construct full file path
      const fullPath = path.join(__dirname, '..', 'uploads', filePath);

      // Check if file exists
      if (fs.existsSync(fullPath)) {
        // Read file asynchronously
        const fileContent = await readFileAsync(fullPath);
        
        // Store file content in the invoice object
        invoice.file_content = fileContent;
      } else {
        console.error('File not found:', fullPath);
      }
    }

    res.status(200).json({ invoices });
  } catch (error) {
    console.error('Error fetching invoices:', error.message);
    res.status(500).json({ error: 'Database query error', message: error.message });
  }
};

// Helper function to read file asynchronously and return binary data
function readFileAsync(filePath) {
  return new Promise((resolve, reject) => {
    fs.readFile(filePath, (err, data) => {
      if (err) {
        reject(err);
      } else {
        resolve(data);
      }
    });
  });
}


exports.getInvoiceImages = async (req, res) => {
  try {
    const userId = req.user.user_id;  // Assuming user_id is passed in the request
    const invoices = await Invoice.findAll({ where: { user_id: userId } });

    if (!invoices || invoices.length === 0) {
      return res.status(404).json({ error: 'User not found or no invoices found' });
    }

    const images = []; // Accumulate images

    for (let i = 0; i < invoices.length; i++) {
      const invoice = invoices[i];
      const imagePath = invoice.file_path;

      if (!imagePath || !fs.existsSync(imagePath)) {
        continue; 
      }

      // Check if the file extension indicates an image
      const imageExtensions = ['.jpg', '.jpeg', '.png', '.gif'];
      const ext = path.extname(imagePath).toLowerCase();
      if (!imageExtensions.includes(ext)) {
        console.log(`Skipping non-image file: ${imagePath}`);
        continue;
      }

      // Read image file and convert it to base64
      const imageBuffer = fs.readFileSync(imagePath);
      const base64Image = imageBuffer.toString('base64');

      // Determine content type based on file extension
      const contentType = getContentType(ext);

      // Construct data URL with base64 encoded image and content type
      const dataUrl = `data:${contentType};base64,${base64Image}`;

      images.push({ dataUrl });
    }

    res.status(200).json({ images });
  } catch (error) {
    console.error('Error fetching invoice images:', error);
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
      return 'application/octet-stream'; // Default to binary data if extension is unknown
  }
}
