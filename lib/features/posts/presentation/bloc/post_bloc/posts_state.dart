import 'package:equatable/equatable.dart';
import 'package:projectclean/features/posts/domain/entities/post.dart';

abstract class PostGetStates extends Equatable {
  const PostGetStates();
}

class PostInitialState extends PostGetStates {
  @override
  List<Object> get props => [];
}

class PostLoadingState extends PostGetStates {
  @override
  List<Object> get props => [];
}

class PostSuccessState extends PostGetStates {
  final List<Post> post;

  const PostSuccessState({required this.post});

  @override
  List<Object> get props => [post];
}

class PostErrorState extends PostGetStates {
  final String message;

  const PostErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
