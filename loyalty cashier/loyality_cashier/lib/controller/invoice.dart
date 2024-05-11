// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:loyality_cashier/controller/api_helper.dart';
import 'package:loyality_cashier/model/invoice.dart';


class InvoiceController {
  final ApiHelper _apiHelper = ApiHelper();


  Future<List<Invoice>>getAllInvoice() async {
    try {
      dynamic jsonObject = await ApiHelper().getRequest("api/invoices/all");
      if (jsonObject == null) {
        return [];
      }
      List<Invoice> result = [];
      jsonObject.forEach((json) {
        result.add(Invoice.fromJson(json));
      });
      return result;
    } catch (ex) {
      if (kDebugMode) {
        print(ex);
      }
      rethrow;
    }
  }

 Future<Invoice> getInvoiceById(int invoiceId) async {
  try {
    dynamic jsonObject = await ApiHelper().getRequest("api/invoices/$invoiceId");
    if (jsonObject == null) {
      // Handle the case where the response is null
      throw Exception('Invoice not found');
    }
    // Convert the JSON object to an Invoice object
    Invoice invoice = Invoice.fromJson(jsonObject);
    return invoice;
  } catch (ex) {
    // Print and rethrow the exception for debugging purposes
    if (kDebugMode) {
      print(ex);
    }
    rethrow;
  }
}



Future<List<Invoice>> getUserInvoice() async {
  try {
    var result = await _apiHelper.getRequest("/api/invoices");
    List<dynamic>? data = result['invoices'];
    if (data != null) {
      List<Invoice> invoices = [];
      
     
      for (var item in data) {
       
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

    
    if (kDebugMode) {
      print("Response: $response");
    }
    if (response is Map<String, dynamic>) {
 
      if (response.containsKey('message')) {
        final message = response['message'];

     
        if (message == 'Loyalty points updated successfully') {
         
          final totalAmount = (response['totalAmount'] as num?)?.toDouble() ?? 0.0;
          if (kDebugMode) {
            print("Total Amount: $totalAmount");
          }

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
       
        return {
          'success': false,
          'message': 'Unexpected response format',
          'totalAmount': 0.0,
        };
      }
    } else {
   
      return {
        'success': false,
        'message': 'Unexpected response format',
        'totalAmount': 0.0,
      };
    }
  } on DioError catch (e) {
    if (kDebugMode) {
      print("Error collecting points: $e");
    }
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

    if (kDebugMode) {
      print("Unexpected error: $e");
    }

    rethrow;
  }
}


Future<Map<String, dynamic>> processScannedData(Uint8List imageBytes) async {
  try {
    
    String base64Image = base64Encode(imageBytes);


    var response = await _apiHelper.postDio(
      "/api/invoices/scan",
      {'image': base64Image},
    );

   
    if (response.statusCode == 200) {
    
      Map<String, dynamic> result = json.decode(response.body);
      return result;
    } else {
     
      throw Exception('Failed to scan invoice: ${response.reasonPhrase}');
    }
  } catch (e) {
   
    if (kDebugMode) {
      print('Error scanning invoice: $e');
    }
    
    throw Exception('Failed to scan invoice: $e');
  }
}}


