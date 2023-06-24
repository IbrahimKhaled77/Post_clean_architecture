import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectclean/core/app_theme.dart';
import 'package:projectclean/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'package:projectclean/features/posts/presentation/bloc/post_bloc/posts_bloc.dart';
import 'package:projectclean/features/posts/presentation/bloc/post_bloc/posts_event.dart';
import 'package:projectclean/features/posts/presentation/pages/posts_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.initial();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.ssl<PostBloc>()..add(GetAllPostEvent())),
        BlocProvider(create: (_) => di.ssl<PostControllerBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        home: const PostHome(),
      ),
    );
  }
}
