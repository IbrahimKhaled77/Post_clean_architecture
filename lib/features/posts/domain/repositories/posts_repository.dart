import 'package:dartz/dartz.dart';
import 'package:projectclean/core/error/failures.dart';
import 'package:projectclean/features/posts/domain/entities/post.dart';

abstract class PostRepositories{
  Future<Either<Failure,List<Post>>> getAllPost();
  Future<Either<Failure,Unit>> addPost(Post post);
  Future<Either<Failure,Unit>> deletePost(int postId);
  Future<Either<Failure,Unit>> updatePost(Post post);
}