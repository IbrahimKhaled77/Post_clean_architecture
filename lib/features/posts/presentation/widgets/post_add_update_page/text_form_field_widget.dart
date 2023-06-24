import 'package:flutter/material.dart';

class TextFromFiledWidget extends StatelessWidget {
  final TextEditingController controller;
  final String massage;
  final bool isUpdate;

  const TextFromFiledWidget(
      {Key? key,
      required this.controller,
      required this.massage,
      required this.isUpdate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(label: Text(massage)),
      maxLines: isUpdate ? 6 : 1,
      maxLength: isUpdate ? 6 : 1,
      validator: (String? value) {
        if (value!.isEmpty) {
          return '$massage Cant be empty';
        }
        return null;
      },
    );
  }
}
