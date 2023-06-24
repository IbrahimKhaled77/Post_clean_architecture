import 'package:flutter/material.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final bool isUpdate;
  final void Function() onPressed;

  const ElevatedButtonWidget(
      {Key? key, required this.isUpdate, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(isUpdate ? Icons.edit : Icons.unarchive_outlined),
      label: Text(
        isUpdate ? 'Update Post' : 'Add Post',
        style: const TextStyle(color: Colors.white),
      ),
      onPressed: onPressed,
    );
  }
}
