import 'package:flutter/material.dart';
import 'package:projectclean/features/posts/domain/entities/post.dart';
import 'package:projectclean/features/posts/presentation/pages/post_add_update_page.dart';

class ElevatedButtonUpdateWidget extends StatelessWidget {
  final Post post;

  const ElevatedButtonUpdateWidget({Key? key, required this.post})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.edit),
      label: const Text(
        'Edit Post',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => PostAddOrUpdate(
                    isUpdate: true,
                    post: post,
                  )),
        );
      },
    );
  }
}
