import 'package:flutter/material.dart';

class ErrorPostWidget extends StatelessWidget {
  final String errorMessage;

  const ErrorPostWidget({Key? key, required this.errorMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              errorMessage,
              style: const TextStyle(
                fontSize: 17.0,
              ),
              maxLines: 2,
            ),
          ),
        ),
      ),
    );
  }
}
