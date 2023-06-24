import 'package:equatable/equatable.dart';
import 'package:projectclean/features/posts/domain/entities/post.dart';

abstract class PostControllerEvent extends Equatable {}

class PostControllerAddEvent extends PostControllerEvent {
  final Post post;

  PostControllerAddEvent({required this.post});

  @override
  List<Object?> get props => [post];
}

class PostControllerDeletedEvent extends PostControllerEvent {
  final int postId;

  PostControllerDeletedEvent({required this.postId});

  @override
  List<Object?> get props => [postId];
}

class PostControllerUpdateEvent extends PostControllerEvent {
  final Post post;

  PostControllerUpdateEvent({required this.post});

  @override
  List<Object?> get props => [post];
}
