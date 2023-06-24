import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectclean/core/error/failures.dart';
import 'package:projectclean/core/strings/failures.dart';
import 'package:projectclean/core/strings/sccuess_messages.dart';
import 'package:projectclean/features/posts/domain/usecases/add_post.dart';
import 'package:projectclean/features/posts/domain/usecases/delete_post.dart';
import 'package:projectclean/features/posts/domain/usecases/update_post.dart';
import 'package:projectclean/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_event.dart';
import 'package:projectclean/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_state.dart';

class PostControllerBloc
    extends Bloc<PostControllerEvent, PostControllerState> {
  final AddPostUseCases addPostUseCases;
  final DeletePostUseCases deletePostUseCases;
  final UpdatePostUseCases updatePostUseCases;

  PostControllerBloc(
      {required this.addPostUseCases,
      required this.deletePostUseCases,
      required this.updatePostUseCases})
      : super(PostControllerInitialState()) {
    on<PostControllerEvent>((event, emit) async {
      if (event is PostControllerAddEvent) {
        emit(PostControllerLoadingState());
        final failureOrMassage = await addPostUseCases(event.post);
        return emit(_addOrDeleteOrUpdate(failureOrMassage, addSuccess));
      } else if (event is PostControllerUpdateEvent) {
        final failureOrMassage = await updatePostUseCases(event.post);
        return emit(_addOrDeleteOrUpdate(failureOrMassage, updateSuccess));
      } else if (event is PostControllerDeletedEvent) {
        final failureOrMassage = await deletePostUseCases(event.postId);
        return emit(_addOrDeleteOrUpdate(failureOrMassage, deleteSuccess));
      }
    });
  }

  PostControllerState _addOrDeleteOrUpdate(
      Either<Failure, Unit> either, String massageSuccess) {
    return either.fold(
      (failure) => PostControllerErrorState(
          massageError: ToMessages.mapFailureToMessages(failure)),
      (_) => PostControllerSuccessState(
        massageSuccess: massageSuccess,
      ),
    );
  }
}
