const Invoice = require('../models/invoice');
const multer = require('multer');
const ScannedInvoices=require('../models/scan_invoice')
const Loyalty = require('../models/loyalty');
const Transaction = require('../models/transaction');
const fs = require('fs');
//const Tesseract = require('tesseract.js');
const qrcode = require('qrcode');
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

     
      const fullPath = path.resolve(filePath);

      const newInvoice = await Invoice.create({
        user_id: userId,
        file_name: filename,
        file_path: fullPath,
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

   
    for (let i = 0; i < invoices.length; i++) {
      const invoice = invoices[i];
      const filePath = invoice.file_path;

    
      const fullPath = path.join(__dirname, '..', 'uploads', filePath);

     
      if (fs.existsSync(fullPath)) {
     
        const fileContent = await readFileAsync(fullPath);
        
       
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

exports.getAllInvoices = async (req, res) => {
  try {
    const invoices = await Invoice.findAll();
    res.json(invoices);
  } catch (error) {
    console.error('Error fetching invoices:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};



exports.getInvoicesById = async (req, res) => {
  const invoiceId = req.params.invoiceId; 
  try {
    const invoices = await Invoice.findOne({ where: { invoice_id: invoiceId } });
    res.json(invoices);
  } catch (error) {
    console.error('Error fetching invoices:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};


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
    const userId = req.user.user_id; 
    const invoices = await Invoice.findAll({ where: { user_id: userId } });

    if (!invoices || invoices.length === 0) {
      return res.status(404).json({ error: 'User not found or no invoices found' });
    }

    const images = []; 

    for (let i = 0; i < invoices.length; i++) {
      const invoice = invoices[i];
      const imagePath = invoice.file_path;

      if (!imagePath || !fs.existsSync(imagePath)) {
        continue; 
      }

    
      const imageExtensions = ['.jpg', '.jpeg', '.png', '.gif'];
      const ext = path.extname(imagePath).toLowerCase();
      if (!imageExtensions.includes(ext)) {
        console.log(`Skipping non-image file: ${imagePath}`);
        continue;
      }

     
      const imageBuffer = fs.readFileSync(imagePath);
      const base64Image = imageBuffer.toString('base64');

    
      const contentType = getContentType(ext);

     
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
      return 'application/octet-stream';
  }
}

// exports.scanInvoice = async (req, res) => {
//   try {
//     const userId = req.user.user_id; 
//     const { totalAmount, invoiceId } = req.body; 

    
//     const hasScannedInvoice = await hasUserScannedInvoice(userId, invoiceId);

//     if (hasScannedInvoice) {
//       return res.status(200).json({ message: 'Loyalty points already earned for this invoice' });
//     }

  
//     let loyalty = await Loyalty.findOne({ where: { user_id: userId } });

//     if (!loyalty) {
     
//       loyalty = await Loyalty.create({
//         user_id: userId,
//         loyalty_point: totalAmount, 
//         last_activity_date: new Date()
//       });
//     } else {
     
//       loyalty.loyalty_point = Number(loyalty.loyalty_point) + Number(totalAmount);
//       loyalty.last_activity_date = new Date();
//       await loyalty.save();
//     }

   
//     await Transaction.create({
//       user_id: userId,
//       points: totalAmount,
//       transaction_type: 'Invoice Scan',
//       transaction_date: new Date()
//     });

    
//     await markInvoiceAsScanned(userId, invoiceId);

//     return res.status(200).json({ message: 'Loyalty points updated successfully', totalAmount });
//   } catch (error) {
//     console.error('Error scanning invoice:', error.message);
//     res.status(500).json({ error: 'Internal server error', message: error.message });
//   }
// };



exports.scanInvoice = async (req, res) => {
  try {
    const userId = req.user.user_id;
    const { invoice_id } = req.body; 

    if (!invoice_id || isNaN(invoice_id)) {
      return res.status(400).json({ error: 'Invalid Invoice ID' });
    }

    const hasScannedInvoice = await hasUserScannedInvoice(userId, invoice_id);

    if (hasScannedInvoice) {
      return res.status(200).json({ message: 'Loyalty points already earned for this invoice' });
    }

    const totalAmount = await getTotalAmountFromInvoiceId(invoice_id);

    if (!totalAmount) {
      return res.status(404).json({ error: 'Invoice not found or total amount not available' });
    }

    let loyalty = await Loyalty.findOne({ where: { user_id: userId } });

    if (!loyalty) {
      loyalty = await Loyalty.create({
        user_id: userId,
        loyalty_point: totalAmount,
        last_activity_date: new Date()
      });
    } else {
      loyalty.loyalty_point += totalAmount;
      loyalty.last_activity_date = new Date();
      await loyalty.save();
    }

    await Transaction.create({
      user_id: userId,
      points: totalAmount,
      transaction_type: 'Invoice Scan',
      transaction_date: new Date()
    });

    await markInvoiceAsScanned(userId, invoice_id);

    return res.status(200).json({ message: 'Loyalty points updated successfully', totalAmount });
  } catch (error) {
    console.error('Error scanning invoice:', error.message);
    return res.status(500).json({ error: 'Internal server error', message: error.message });
  }
};


// Perform OCR on the scanned image to extract text
async function getTotalAmountFromInvoiceId(invoiceId) {
  try {
   
    const invoice = await Invoice.findOne({ where: { invoice_id: invoiceId } });
    
    if (invoice) {
      return invoice.total_amount;
    } else {
      return null; 
    }
  } catch (error) {
    console.error('Error retrieving total amount from invoice ID:', error.message);
    throw error; 
  }
}

async function hasUserScannedInvoice(userId, invoiceId) {
  const scannedInvoice = await ScannedInvoices.findOne({ where: { user_id: userId, invoice_id: invoiceId } });
  return !!scannedInvoice;
}


async function markInvoiceAsScanned(userId, invoiceId) {
  await ScannedInvoices.create({ user_id: userId, invoice_id: invoiceId });
}


exports.generateBarcodeInvoice = async (req, res) => {
  try {
    const { invoice_id, total_amount } = req.body; 

    const barcodeValue = generateBarcodeValue(invoice_id, total_amount); 

    const barcodeData = {
      invoice_id,
      total_amount,
    };

  

    qrcode.toDataURL(barcodeValue, barcodeData, (err, qrCodeData) => {
      if (err) {
        res.status(500).send('Error generating QR code');
      } else {
        res.setHeader('Content-Type', 'image/png');
        res.setHeader('Content-Disposition', 'attachment; filename="qr-code.png"');
        const dataUri = `data:image/png;base64,${qrCodeData.split(',')[1]}`;
        const imageBuffer = Buffer.from(dataUri.split(',')[1], 'base64');
        res.setHeader('Content-Length', imageBuffer.length);
        res.send(imageBuffer);
      }
    });
  } catch (error) {
    console.error('Error generating barcode and QR code:', error);
    res.status(500).json({ message: 'Error generating barcode and QR code' });
  }
};

const generateBarcodeValue = (invoice_id, total_amount) => {
  return `invoice_id:${invoice_id}-total_amount:${total_amount}`;
};
