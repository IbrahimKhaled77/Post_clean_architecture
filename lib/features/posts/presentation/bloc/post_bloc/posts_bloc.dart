import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectclean/core/error/failures.dart';
import 'package:projectclean/core/strings/failures.dart';
import 'package:projectclean/features/posts/domain/entities/post.dart';
import 'package:projectclean/features/posts/domain/usecases/get_all_posts.dart';
import 'package:projectclean/features/posts/presentation/bloc/post_bloc/posts_event.dart';
import 'package:projectclean/features/posts/presentation/bloc/post_bloc/posts_state.dart';

class PostBloc extends Bloc<PostGetEvent, PostGetStates> {
  final GetAllPostUseCase getAllPostUseCase;

  PostBloc({required this.getAllPostUseCase}) : super(PostInitialState()) {
    on<PostGetEvent>((event, emit) async {
      if (event is GetAllPostEvent) {
        emit(PostLoadingState());
        final failureOrPosts = await getAllPostUseCase();
        return emit(getAllPostUseCaseOrRefresh(failureOrPosts));
      } else if (event is RefreshPostEvent) {
        emit(PostLoadingState());
        final failureOrPosts = await getAllPostUseCase();
        return emit(getAllPostUseCaseOrRefresh(failureOrPosts));
      }
    });
  }

  PostGetStates getAllPostUseCaseOrRefresh(Either<Failure, List<Post>> either) {
    return either.fold(
      (failure) =>
          PostErrorState(message: ToMessages.mapFailureToMessages(failure)),
      (post) => PostSuccessState(post: post),
    );
  }
}
