import 'package:flutter/material.dart';
import 'package:projectclean/features/posts/domain/entities/post.dart';
import 'package:projectclean/features/posts/presentation/widgets/post_detail_page/post_detail_widget.dart';

class PostDeleteOrEdite extends StatelessWidget {
  final Post post;

  const PostDeleteOrEdite({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  AppBar _appBar() => AppBar(
        title: const Text(
          'delete Or Edite',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
      );

  Widget _body() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ItemPostWidget(post: post),
      ),
    );
  }
}
