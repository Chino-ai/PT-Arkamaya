import 'package:flutter/cupertino.dart';
import 'package:pt_arkamaya/model/list_user.dart';
import 'package:pt_arkamaya/utils/result_state.dart';

import '../api/api_service.dart';

class ListUserProvider extends ChangeNotifier{
  final ApiService apiService;

  ListUserProvider({required this.apiService}){
    fetchListUser();
  }

  ListUser? _listUser;
  ResultState? _state;
  String _message = '';

  String get message => _message;

  ListUser? get result => _listUser;

  ResultState? get state => _state;

  Future<dynamic> fetchListUser() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final user = await apiService.getListUser();
      if (user.data.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _listUser = user;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}