import 'package:flutter/material.dart';
import 'package:todo_list_project/app/ui/my_flutter_app_icons.dart';

class TodoListField extends StatelessWidget {
  final String label;
  final bool obscure;
  final Icon? icon;
  final ValueNotifier<bool> obscureVN;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;

  TodoListField({
    super.key,
    required this.label,
    this.obscure = false,
    this.icon,
    this.controller,
    this.validator,
  })  : obscureVN = ValueNotifier(obscure),
        assert(
          obscure == true ? icon == null : true,
        );

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: obscureVN,
      builder: (_, obscureValue, child) {
        return TextFormField(
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
              labelText: label,
              labelStyle: TextStyle(color: Colors.black, fontSize: 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: Colors.purple,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.red),
              ),
              isDense: true,
              suffixIcon: this.icon ??
                  (obscure == true
                      ? IconButton(
                          onPressed: () {
                            obscureVN.value = !obscureValue;
                          },
                          icon: Icon(
                            !obscureValue
                                ? MyFlutterAppIcons.eye_slash
                                : MyFlutterAppIcons.eye,
                            size: 15,
                          ),
                        )
                      : null)),
          obscureText: obscureValue,
        );
        ;
      },
    );
  }
}
