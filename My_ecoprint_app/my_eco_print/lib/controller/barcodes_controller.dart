// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:my_eco_print/data/module/barcode.dart';

import 'api_helper.dart';

class BarcodeController {
  late Dio dio;

  BarcodeController() {
    dio = Dio();
  }

  Future<dynamic> createBarcode(Barcodes barcode) async {
    try {
      var result =
          await ApiHelper().postRequest("/api/barcodes", barcode.toJson());
      print("Response: $result");
      print("JSON Data: ${barcode.toJson()}");

      return result;
    } catch (e) {
      print("Error creating barcode: $e");
      print("JSON Data: ${barcode.toJson()}");

      rethrow;
    }
  }

  Future<Barcodes> getBarcode() async {
    try {
      var result = await ApiHelper().getRequest("/api/barcodes");
      if (result != null) {
        return Barcodes.fromJson(result);
      } else {
        throw Exception("No data received from the backend");
      }
    } catch (e) {
      print("Error in getBarcode: $e");
      rethrow;
    }
  }

  Future<List<Barcodes>> getAll() async {
    try {
      dynamic jsonObject = await ApiHelper().getRequest("/api/barcodes");
      if (jsonObject == null) {
        return [];
      }
      List<Barcodes> result = [];
      jsonObject.forEach((json) {
        result.add(Barcodes.fromJson(json));
      });
      return result;
    } catch (ex) {
      print(ex);
      rethrow;
    }
  }

  Future<dynamic> deleteBarcode(int barcodeId) async {
    try {
      var result = await ApiHelper().deleteRequest("/api/barcodes$barcodeId");
      print(result);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> scanBarcode(String barcode) async {
    try {
      final response = await ApiHelper()
          .postRequest('/api/barcodes/scanBarcode', {'barcode_value': barcode});

      print(response);
      return response;
    } catch (e) {
      print('Error sending barcode to the backend: $e');
    }
  }

  Future<Map<String, dynamic>> checkBarcode(String barcodeValue) async {
    try {
      final response = await ApiHelper().postRequest(
        '/api/barcodes/checkBarcode',
        {'barcodeValue': barcodeValue},
      );

      return response;
    } catch (e) {
      print('Error checking barcode: $e');
      rethrow;
    }
  }
Future<List<Map<String, dynamic>>> getBarcodeByStoreAndOfferId(int storeId, int offerId) async {
  try {
    dynamic jsonObject = await ApiHelper().getRequest("/api/barcodes/$storeId/$offerId");
    if (jsonObject.containsKey("data") && jsonObject["data"].containsKey("barcode")) {
      jsonObject = jsonObject["data"]["barcode"];

      // Convert Barcodes object to map
      List<Map<String, dynamic>> barcodes = [Barcodes.fromJson(jsonObject).toJson()];

      return barcodes;
    } else {
      throw Exception("Barcode not found");
    }
  } catch (e) {
    print(e);
    throw e; 
  }
}
Future<Map<String, dynamic>?> generateBarcodeAndQRCode() async {
  try {
   Uint8List? qrCodeImageBytes;
  String barcodeValue = '';


  int? offerId;
  int? storeId;
  int? userId;
int ?barcodeId;
    if (barcodeValue.isNotEmpty && qrCodeImageBytes != null) {
    
      return {
        'barcodeValue': barcodeValue,
        'qrCodeImageBytes': qrCodeImageBytes,
      };
    }


    final response = await ApiHelper().postDioForImage(
      '/api/barcodes/offerstoreBarcode',
      {
        'storeId': storeId.toString(),
        'offerId': offerId.toString(),
      },
    );

    if (response != null) {
      if (response is List<int>) {
      
        return {
          'barcodeValue': barcodeValue, 
          'qrCodeImageBytes': Uint8List.fromList(response),
        };
      } else {

        print('Error: Invalid response format');
        return null;
      }
    } else {

      print('Error: No response received');
      return null;
    }
  } catch (e) {
  
    print('Error generating or retrieving barcode: $e');
    return null;
  }
}



Future<Map<String, dynamic>?> collectPointsFromBarcode(String barcode) async {
    try {
      final response = await ApiHelper().postRequest(
        '/api/barcodes/collectPointsFromBarcode',
        {'barcodeValue': barcode},
      );

      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Error collecting points from barcode: $e');
      }
      return null;
    }
  }


Future<bool> getBarcodeIsRead(int barcodeId) async {
  try {
    final jsonResponse = await ApiHelper().getRequest("/api/barcodes/$barcodeId");

    
    if (jsonResponse.containsKey('isRead')) {
     
      return jsonResponse['isRead'];
    } else {
     
      throw Exception('Barcode status not found in the response');
    }
  } catch (e) {
    
    print('Error getting barcode status: $e');
    throw e;
  }
}

void checkBarcodeStatus(int barcodeId) async {
  try {
    bool isRead = await getBarcodeIsRead(barcodeId);
    if (isRead) {
      print('Barcode with ID $barcodeId is read');
    } else {
      print('Barcode with ID $barcodeId is not read');
    }
  } catch (e) {
    print('Error occurred while checking barcode status: $e');
  }
}


}