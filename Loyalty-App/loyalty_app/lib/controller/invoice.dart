import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:loyalty_app/controller/api_helper.dart';
import 'package:loyalty_app/model/invoice.dart';
import 'package:loyalty_app/model/transaction.dart';

class InvoiceController {
  final ApiHelper _apiHelper = ApiHelper();

Future<List<Invoice>> getUserInvoice() async {
  try {
    var result = await _apiHelper.getRequest("/api/invoices");
    List<dynamic>? data = result['invoices'];
    if (data != null) {
      List<Invoice> invoices = [];
      
      // Construct Invoice objects
      for (var item in data) {
        // Read image bytes asynchronously
        List<Uint8List> imageList = await _apiHelper.getInvoiceImages(item['file_path']);
        
        invoices.add(Invoice(
          invoiceId: item['invoice_id'],
          uploadDate: item['upload_date'],
          filePath: item['file_path'],
          userId: item['user_id'],
          imageBytesList: imageList, totalAmount: 0.0,
        ));
      }
      
      return invoices;
    } else {
      throw Exception('Failed to fetch user invoices: No data');
    }
  } catch (e) {
    throw Exception('Failed to fetch user invoices: $e');
  }
}


Future<Map<String, dynamic>> collectPoint({
  required int invoiceId,
}) async {
  try {
    final response = await ApiHelper().postDio(
      "/api/invoices/scan",
      {'invoice_id': invoiceId.toString()},
    );

    // Print response for inspection
    print("Response: $response");

    // Check if response is in the expected format
    if (response is Map<String, dynamic>) {
      // Handle successful response
      if (response.containsKey('message')) {
        final message = response['message'];

        // Check if the message indicates success or failure
        if (message == 'Loyalty points updated successfully') {
          // Parse totalAmount as a double
          final totalAmount = (response['totalAmount'] as num?)?.toDouble() ?? 0.0;
          print("Total Amount: $totalAmount");

          // Uncomment and implement transaction creation if needed
          // await createTransaction(totalAmount);

          return {
            'success': true,
            'message': message,
            'totalAmount': totalAmount,
          };
        } else {
          return {
            'success': false,
            'message': message,
            'totalAmount': 0.0,
          };
        }
      } else {
        // Handle unexpected response format
        return {
          'success': false,
          'message': 'Unexpected response format',
          'totalAmount': 0.0,
        };
      }
    } else {
      // Handle unexpected response format
      return {
        'success': false,
        'message': 'Unexpected response format',
        'totalAmount': 0.0,
      };
    }
  } on DioError catch (e) {
    // Handle Dio error
    print("Error collecting points: $e");
    if (e.response?.statusCode == 404) {
      return {
        'success': false,
        'message': 'Invoice not found or total amount not available',
        'totalAmount': 0.0,
      };
    } else {
      return {
        'success': false,
        'message': 'An error occurred while connecting to the server',
        'totalAmount': 0.0,
      };
    }
  } catch (e) {
    // Handle unexpected error
    print("Unexpected error: $e");
    // Rethrow or handle the error appropriately
    rethrow;
  }
}


Future<Map<String, dynamic>> processScannedData(Uint8List imageBytes) async {
  try {
    // Convert image bytes to base64 string
    String base64Image = base64Encode(imageBytes);

    // Send the base64 encoded image to the backend for scanning
    var response = await _apiHelper.postDio(
      "/api/invoices/scan",
      {'image': base64Image},
    );

    // Check if the request was successful
    if (response.statusCode == 200) {
      // Decode the response body JSON string
      Map<String, dynamic> result = json.decode(response.body);
      return result;
    } else {
      // If the request was not successful, throw an exception
      throw Exception('Failed to scan invoice: ${response.reasonPhrase}');
    }
  } catch (e) {
    // Print the error message
    print('Error scanning invoice: $e');
    // Throw an exception to handle the error
    throw Exception('Failed to scan invoice: $e');
  }
}}


