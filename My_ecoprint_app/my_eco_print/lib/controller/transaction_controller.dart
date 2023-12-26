


// ignore_for_file: avoid_print, non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:my_eco_print/data/module/transaction.dart';

import 'api_helper.dart';
class TransactionController{

 late Dio dio;

  TransactionController() {
    dio = Dio();
  }



// Flutter code
Future<List<dynamic>> getFilteredTransactions(String sort) async {
  try {
    final result = await ApiHelper().getRequest("/api/transactions/sort/$sort");

    if (result != null && result is List<dynamic>) {
      print('Response: $result');
      return result; 
    } else {
      print('Invalid response format');
      return [];
    }
  } catch (error) {
    print('Error: $error');
    throw error; 
  }
}


Future<List<Transaction>> getAllTransactions() async {
  try {
    dynamic jsonResponse = await ApiHelper().getRequest("/api/transactions");

    if (jsonResponse == null || !(jsonResponse is Map<String, dynamic>)) {
      return [];
    }

   
    List<Transaction> result = (jsonResponse['transactions'] as List<dynamic>).map((transactionJson) {
      return Transaction.fromJson(transactionJson);
    }).toList();

    return result;
  } catch (ex) {
    print(ex);
    rethrow;
  }
}



}





