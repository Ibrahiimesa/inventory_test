import 'package:flutter/cupertino.dart';
import 'package:rds_test/data/model/response/supplier_response.dart';

import '../data/api/api_service.dart';
import '../utils/result_state.dart';

class SupplierProvider extends ChangeNotifier {
  final ApiService apiService;

  SupplierProvider({required this.apiService}) {
    fetchSupplier();
  }

  List<SupplierData> _supplierData = [];
  late SupplierResponse _supplierResult;
  late ResultState _state;
  String _message = '';
  int _currentPage = 1;
  final int _limit = 10;
  bool _isFetching = false;

  List<SupplierData> get supplierData => _supplierData;

  SupplierResponse get result => _supplierResult;

  ResultState get state => _state;

  String get message => _message;

  bool get isFetching => _isFetching;

  Future<void> fetchSupplier() async {
    if (_isFetching) return;

    _isFetching = true;

    try {
      _state =
          _supplierData.isEmpty ? ResultState.loading : ResultState.hasData;
      notifyListeners();

      final response = await apiService.getSupplier(_currentPage, _limit);

      if (response.data.isEmpty) {
        if (_currentPage == 1) {
          _state = ResultState.noData;
          _message = 'No data available';
        } else {
          print('No more data to fetch.');
          _isFetching = false; // Important to stop loading here
          return;
        }
      } else {
        _supplierData.addAll(response.data);
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
      fetchSupplier();
    }
  }
}
