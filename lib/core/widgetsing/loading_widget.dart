import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: SizedBox(
            height: 30,
            width: 30,
            child: CircularProgressIndicator(
              color: Colors.blue,
            )),
      ),
    );
  }
}
