import 'package:flutter/material.dart';
import 'package:projectclean/features/posts/domain/entities/post.dart';
import 'package:projectclean/features/posts/presentation/pages/post_detail_page.dart';

class ListPostWidget extends StatelessWidget {
  final List<Post> post;

  const ListPostWidget({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return Card(
          elevation: 10.0,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostDeleteOrEdite(
                    post: post[index],
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    post[index].title.toString(),
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
                    post[index].body.toString(),
                    style: const TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        height: 12.0,
      ),
      itemCount: post.length,
    );
  }
}
