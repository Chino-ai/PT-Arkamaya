import 'package:flutter/cupertino.dart';
import 'package:pt_arkamaya/model/create_user.dart';
import 'package:pt_arkamaya/model/list_user.dart';
import 'package:pt_arkamaya/utils/result_state.dart';

import '../api/api_service.dart';

class CreateUserProvider extends ChangeNotifier{
  final ApiService apiService;

  CreateUserProvider({required this.apiService});

  CreateUser? _createUser;
  ResultState? _state;
  String _message = '';

  String get message => _message;

  CreateUser? get result => _createUser;

  ResultState? get state => _state;

  Future<dynamic> fetchCreateUser(String name, job) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final user = await apiService.getCreateUser(name, job);
      if (user.name.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _createUser = user;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}