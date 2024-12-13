import 'package:flutter/material.dart';
import 'package:rds_test/data/model/response/inventory_response.dart';

import '../data/api/api_service.dart';
import '../utils/result_state.dart';

class InventoryProvider extends ChangeNotifier {
  final ApiService apiService;

  InventoryProvider({required this.apiService}) {
    _fetchInventory();
  }

  List<InventoryData> _inventoryData = [];
  late InventoryResponse _inventoryResult;
  late ResultState _state;
  String _message = '';
  int _currentPage = 1;
  final int _limit = 10;
  bool _isFetching = false;

  List<InventoryData> get inventoryData => _inventoryData;

  InventoryResponse get result => _inventoryResult;

  ResultState get state => _state;

  String get message => _message;

  bool get isFetching => _isFetching;

  Future<void> _fetchInventory() async {
    if (_isFetching) return;

    _isFetching = true;

    try {
      _state =
          _inventoryData.isEmpty ? ResultState.loading : ResultState.hasData;
      notifyListeners();

      final response = await apiService.getInventory(_currentPage, _limit);

      if (response.data.isEmpty) {
        if (_currentPage == 1) {
          _state = ResultState.noData;
          _message = 'No data available';
        } else {
          _isFetching = false;
          return;
        }
      } else {
        _inventoryData.addAll(response.data);
        _state = ResultState.hasData;
        _currentPage++;
      }
      notifyListeners();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error --> $e';
      notifyListeners();
    } finally {
      _isFetching = false;
    }
  }

  void loadMore() {
    if (!_isFetching && _state != ResultState.noData) {
      _fetchInventory();
    }
  }
}
