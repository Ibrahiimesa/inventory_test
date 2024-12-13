import 'package:flutter/cupertino.dart';
import 'package:rds_test/data/model/request/inventory_request.dart';

import '../data/api/api_service.dart';
import '../utils/result_state.dart';

class AddInventoryProvider extends ChangeNotifier {
  final ApiService apiService;

  AddInventoryProvider({required this.apiService});

  ResultState _state = ResultState.noData;
  String? _errorMessage;

  ResultState get state => _state;

  String? get errorMessage => _errorMessage;

  Future<String> addInventory(InventoryRequest inventory) async {
    _state = ResultState.loading;
    notifyListeners();

    try {
      await apiService.addInventory(inventory);
      _state = ResultState.noData;
      notifyListeners();
      return 'Inventory added successfully!';
    } catch (e) {
      _state = ResultState.error;
      _errorMessage = 'An error occurred: $e';
      notifyListeners();
      return 'Failed to add inventory';
    } finally {
      notifyListeners();
    }
  }

  Future<String> updateInventory(InventoryRequest inventory) async {
    _state = ResultState.loading;
    notifyListeners();

    try {
      await apiService.updateInventory(inventory);
      _state = ResultState.noData;
      notifyListeners();
      return 'Inventory update successfully!';
    } catch (e) {
      _state = ResultState.error;
      _errorMessage = 'An error occurred: $e';
      notifyListeners();
      return 'Failed to update Inventory';
    } finally {
      notifyListeners();
    }
  }
}
