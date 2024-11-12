
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class DefaultNotifier extends ChangeNotifier{
  bool _loading = false;
  String? _error;
  bool _success = false;

  bool get loading => _loading;
  String? get error => _error;
  bool get isSuccess => _success;
  bool get hasError => _error != null;

  void showLoading() => _loading = true;

  void hideLoading() => _loading = false;

  void setError(String? error) {
    _error = error;
  }

  void success() => _success = true;

  void showLoadingAndResetState(){
    showLoading();
    resetState();
  }
  
  void resetState() {
    setError(error);
    _success = false;
  }

}