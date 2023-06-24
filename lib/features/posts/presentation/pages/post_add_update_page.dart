import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectclean/core/util/snackbar_message.dart';
import 'package:projectclean/core/widgetsing/loading_widget.dart';
import 'package:projectclean/features/posts/domain/entities/post.dart';
import 'package:projectclean/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'package:projectclean/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_state.dart';
import 'package:projectclean/features/posts/presentation/pages/posts_page.dart';
import 'package:projectclean/features/posts/presentation/widgets/post_add_update_page/form_widget.dart';

class PostAddOrUpdate extends StatelessWidget {
  final bool isUpdate;
  final Post? post;

  const PostAddOrUpdate({Key? key, required this.isUpdate, this.post})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _bodsy(),
    );
  }

  AppBar _appBar() => AppBar(
        title: Text(
          isUpdate ? "Update Post" : "Add Post",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
          ),
        ),
      );

  Widget _bodsy() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocConsumer<PostControllerBloc, PostControllerState>(
          listener: (context, state) {
            if (state is PostControllerSuccessState) {
              SnackBarMessage.showSuccessSnackBar(
                message: state.massageSuccess,
                context: context,
              );

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const PostHome()),
                (route) => false,
              );
            } else if (state is PostControllerErrorState) {
              SnackBarMessage.showErrorSnackBar(
                message: state.massageError,
                context: context,
              );
            }
          },
          builder: (context, state) {
            if (state is PostControllerLoadingState) {
              return const LoadingWidget();
            }
            return TextFromWidget(
                isUpdate: isUpdate, post: isUpdate ? post : null);
          },
        ),
      ),
    );
  }
}
