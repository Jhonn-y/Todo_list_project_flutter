
import 'package:flutter/widgets.dart';

class Validators {
  Validators._();

  static FormFieldValidator compare(TextEditingController? controller, String message){
    return (value) {
      final valueCompare = controller?.text ?? '';
      if (value == null || (value != null && value != valueCompare)) {
        return message;
        }
      return null;
    };
  }
}