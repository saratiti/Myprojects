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
}
