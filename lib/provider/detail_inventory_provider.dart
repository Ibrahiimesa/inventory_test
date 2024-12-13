import 'package:flutter/cupertino.dart';
import 'package:rds_test/data/model/response/detail_inventory_response.dart';

import '../data/api/api_service.dart';
import '../utils/result_state.dart';

class DetailInventoryProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  DetailInventoryProvider({required this.apiService, required this.id}) {
    fetchDetailInventory(id);
  }

  late DetailInventoryResponse _detailInventoryResult;
  late ResultState _state;
  String _message = '';

  DetailInventoryResponse get result => _detailInventoryResult;

  ResultState get state => _state;

  String get message => _message;

  Future<dynamic> fetchDetailInventory(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final response = await apiService.getDetailInventory(id);
      _state = ResultState.hasData;
      notifyListeners();
      return _detailInventoryResult = response;
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
