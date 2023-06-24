import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectclean/core/widgetsing/loading_widget.dart';
import 'package:projectclean/features/posts/presentation/bloc/post_bloc/posts_bloc.dart';
import 'package:projectclean/features/posts/presentation/bloc/post_bloc/posts_event.dart';
import 'package:projectclean/features/posts/presentation/bloc/post_bloc/posts_state.dart';
import 'package:projectclean/features/posts/presentation/pages/post_add_update_page.dart';
import 'package:projectclean/features/posts/presentation/widgets/posts_page/message_display_widget.dart';
import 'package:projectclean/features/posts/presentation/widgets/posts_page/post_list_widget.dart';

class PostHome extends StatelessWidget {
  const PostHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
      floatingActionButton: _floatingActionButton(context),
    );
  }

  AppBar _appBar() => AppBar(
        title: const Text(
          'Home',
          style: TextStyle(
            fontSize: 19.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

  Widget _body() {
    return BlocBuilder<PostBloc, PostGetStates>(
      builder: (context, state) {
        if (state is PostLoadingState) {
          return const LoadingWidget();
        } else if (state is PostSuccessState) {
          return RefreshIndicator(
            onRefresh: () => _onRefresh(context),
            child: ListPostWidget(post: state.post),
          );
        } else if (state is PostErrorState) {
          return ErrorPostWidget(errorMessage: state.message);
        } else {
          return const LoadingWidget();
        }
      },
    );
  }

  Widget _floatingActionButton(BuildContext context) => FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const PostAddOrUpdate(
                isUpdate: false,
              ),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      );

  Future<void> _onRefresh(context) async {
    BlocProvider.of<PostBloc>(context).add(RefreshPostEvent());
    //return PostBloc.get(context).add(RefreshPostEvent());
  }
}
