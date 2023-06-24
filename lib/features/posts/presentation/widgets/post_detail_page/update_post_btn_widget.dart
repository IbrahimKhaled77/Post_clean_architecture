import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectclean/core/util/snackbar_message.dart';
import 'package:projectclean/core/widgetsing/loading_widget.dart';
import 'package:projectclean/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'package:projectclean/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_state.dart';
import 'package:projectclean/features/posts/presentation/pages/posts_page.dart';
import 'package:projectclean/features/posts/presentation/widgets/post_detail_page/delete_dialog_widget.dart';

class ElevatedButtonDeleteWidget extends StatelessWidget {
  final int postId;

  const ElevatedButtonDeleteWidget({Key? key, required this.postId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          Colors.redAccent,
        ),
      ),
      icon: const Icon(Icons.delete_outline),
      label: const Text(
        'delete Post',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () => _onPressedDelete(context, postId),
    );
  }

  void _onPressedDelete(BuildContext context, int postId) {
    showDialog(
        context: context,
        builder: (context) {
          return BlocConsumer<PostControllerBloc, PostControllerState>(
            listener: (context, state) {
              if (state is PostControllerSuccessState) {
                SnackBarMessage.showSuccessSnackBar(
                    context: context, message: state.massageSuccess);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (_) => const PostHome(),
                    ),
                    (route) => false);
              } else if (state is PostControllerErrorState) {
                SnackBarMessage.showErrorSnackBar(
                    context: context, message: state.massageError);
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              if (state is PostControllerLoadingState) {
                return const AlertDialog(title: LoadingWidget());
              } else {
                return ShowDialogWidget(
                  postId: postId,
                );
              }
            },
          );
        });
  }
}
