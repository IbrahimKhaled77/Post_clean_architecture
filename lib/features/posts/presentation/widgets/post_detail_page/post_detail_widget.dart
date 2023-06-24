import 'package:flutter/material.dart';
import 'package:projectclean/features/posts/domain/entities/post.dart';
import 'package:projectclean/features/posts/presentation/widgets/post_detail_page/delete_post_btn_widget.dart';
import 'package:projectclean/features/posts/presentation/widgets/post_detail_page/update_post_btn_widget.dart';

class ItemPostWidget extends StatelessWidget {
  final Post post;

  const ItemPostWidget({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Column(
            children: [
              Text(
                post.title,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                post.body,
                style: const TextStyle(
                    fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.grey),
              ),

            ],
          ),
        ),
        const SizedBox(
          height: 50.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButtonUpdateWidget(
              post: post,
            ),
            ElevatedButtonDeleteWidget(
              postId: post.id!,
            ),
          ],
        ),
      ],
    );
  }
}
