import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:projectclean/core/network/network_info.dart';
import 'package:projectclean/features/posts/data/datasources/post_local_data_source.dart';
import 'package:projectclean/features/posts/data/datasources/post_remote_data_source.dart';
import 'package:projectclean/features/posts/data/repositoirs/post_repository_imp.dart';
import 'package:projectclean/features/posts/domain/repositories/posts_repository.dart';
import 'package:projectclean/features/posts/domain/usecases/add_post.dart';
import 'package:projectclean/features/posts/domain/usecases/delete_post.dart';
import 'package:projectclean/features/posts/domain/usecases/get_all_posts.dart';
import 'package:projectclean/features/posts/domain/usecases/update_post.dart';
import 'package:projectclean/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'package:projectclean/features/posts/presentation/bloc/post_bloc/posts_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final ssl = GetIt.instance;

Future<void> initial() async {
  ///feature - posts,

  //bloc
  ssl.registerFactory(() => PostBloc(
        getAllPostUseCase: ssl(),
      ));
  ssl.registerFactory(() => PostControllerBloc(
        addPostUseCases: ssl(),
        deletePostUseCases: ssl(),
        updatePostUseCases: ssl(),
      ));

  //use_case
  ssl.registerLazySingleton(() => GetAllPostUseCase(ssl()));
  ssl.registerLazySingleton(() => AddPostUseCases(ssl()));
  ssl.registerLazySingleton(() => UpdatePostUseCases(ssl()));
  ssl.registerLazySingleton(() => DeletePostUseCases(ssl()));
  //Repository

  ssl.registerLazySingleton<PostRepositories>(
    () => RepositoriesImp(
      localDataSources: ssl(),
      remoteDataSources: ssl(),
      netWorkInfo: ssl(),
    ),
  );
  //Data Sources

  ssl.registerLazySingleton<LocalDataSources>(
    () => LocalDataSourcesImp(
      sharedPreferences: ssl(),
    ),
  );
  ssl.registerLazySingleton<RemoteDataSources>(
    () => RemoteDataSourcesImp(
      client: ssl(),
    ),
  );

  ///core
  ssl.registerLazySingleton<NetWorkInfo>(
    () => NetWorkInfoImp(
      isConnected: ssl(),
    ),
  );

  ///External
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  ssl.registerLazySingleton(() => sharedPreferences);
  ssl.registerLazySingleton(() => http.Client());
  ssl.registerLazySingleton(() => InternetConnectionChecker());
}
