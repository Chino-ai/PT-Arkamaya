import 'package:flutter/cupertino.dart';
import 'package:pt_arkamaya/model/list_user.dart';
import 'package:pt_arkamaya/model/single_user.dart';
import 'package:pt_arkamaya/utils/result_state.dart';

import '../api/api_service.dart';

class SingleUserProvider extends ChangeNotifier{
  final ApiService apiService;
  final String id;

  SingleUserProvider({required this.apiService,required this.id}){
    fetchSingleUser();
  }

  SingleUser? _singleUser;
  ResultState? _state;
  String _message = '';

  String get message => _message;

  SingleUser? get result => _singleUser;

  ResultState? get state => _state;

  Future<dynamic> fetchSingleUser() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final user = await apiService.getSingleUser(id);
      if (user.data.id.toString().isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _singleUser = user;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}