import 'package:flutter/material.dart';

class CompanyProvider extends ChangeNotifier {
  int _companyId = 0;

  int get companyId => _companyId;

  void setCompanyId(int companyId) {
    _companyId = companyId;
    notifyListeners();
  }
}
