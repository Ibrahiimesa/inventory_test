import 'package:flutter/cupertino.dart';
import 'package:rds_test/data/model/request/supplier_request.dart';

import '../data/api/api_service.dart';
import '../utils/result_state.dart';

class AddSupplierProvider extends ChangeNotifier {
  final ApiService apiService;

  AddSupplierProvider({required this.apiService});

  ResultState _state = ResultState.noData;
  String? _errorMessage;

  ResultState get state => _state;

  String? get errorMessage => _errorMessage;

  Future<String> addSupplier(SupplierDataRequest supplier) async {
    _state = ResultState.loading;
    notifyListeners();

    try {
      await apiService.addSupplier(supplier);
      _state = ResultState.noData;
      notifyListeners();
      return 'Supplier added successfully!';
    } catch (e) {
      _state = ResultState.error;
      _errorMessage = 'An error occurred: $e';
      notifyListeners();
      return 'Failed to add supplier';
    } finally {
      notifyListeners();
    }
  }

  Future<String> updateSupplier(SupplierDataRequest supplier) async {
    _state = ResultState.loading;
    notifyListeners();

    try {
      await apiService.updateSupplier(supplier);
      _state = ResultState.noData;
      notifyListeners();
      return 'Supplier update successfully!';
    } catch (e) {
      _state = ResultState.error;
      _errorMessage = 'An error occurred: $e';
      notifyListeners();
      return 'Failed to update supplier';
    } finally {
      notifyListeners();
    }
  }
}
