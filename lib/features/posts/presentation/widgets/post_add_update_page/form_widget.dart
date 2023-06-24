import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectclean/features/posts/domain/entities/post.dart';
import 'package:projectclean/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'package:projectclean/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_event.dart';
import 'package:projectclean/features/posts/presentation/widgets/post_add_update_page/form_submit_btn.dart';
import 'package:projectclean/features/posts/presentation/widgets/post_add_update_page/text_form_field_widget.dart';

class TextFromWidget extends StatefulWidget {
  final bool isUpdate;
  final Post? post;

  const TextFromWidget({Key? key, required this.isUpdate, this.post})
      : super(key: key);

  @override
  State<TextFromWidget> createState() => _TextFromWidgetState();
}

class _TextFromWidgetState extends State<TextFromWidget> {
  final keys = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  @override
  void initState() {
    if (widget.isUpdate) {
      titleController.text = widget.post!.title;
      bodyController.text = widget.post!.body;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: keys,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFromFiledWidget(
              controller: titleController,
              massage: 'Title',
              isUpdate: false,
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextFromFiledWidget(
              controller: bodyController,
              massage: 'body',
              isUpdate: true,
            ),
            const SizedBox(
              height: 50.0,
            ),
            ElevatedButtonWidget(
              isUpdate: widget.isUpdate,
              onPressed: _onPressed,
            ),
          ],
        ),
      ),
    );
  }

  void _onPressed() {
    if (keys.currentState!.validate()) {
      final postModels = Post(
        id: widget.isUpdate ? widget.post!.id : null,
        title: titleController.text,
        body: bodyController.text,
      );
      if (widget.isUpdate) {
        BlocProvider.of<PostControllerBloc>(context)
            .add(PostControllerUpdateEvent(post: postModels));
      } else {
        BlocProvider.of<PostControllerBloc>(context)
            .add(PostControllerAddEvent(post: postModels));
      }
    }
  }
}
