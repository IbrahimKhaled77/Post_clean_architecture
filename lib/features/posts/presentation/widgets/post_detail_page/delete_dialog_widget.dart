import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectclean/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'package:projectclean/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_event.dart';

class ShowDialogWidget extends StatelessWidget {
  final int postId;

  const ShowDialogWidget({Key? key, required this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Are you Sure ?"),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No')),
        const SizedBox(
          width: 20.0,
        ),
        TextButton(
            onPressed: () {
              BlocProvider.of<PostControllerBloc>(context)
                  .add(PostControllerDeletedEvent(postId: postId));
            },
            child: const Text('yes')),
      ],
    );
  }
}
