import 'package:dartz/dartz.dart';
import 'package:projectclean/core/error/failures.dart';
import 'package:projectclean/features/posts/domain/entities/post.dart';
import 'package:projectclean/features/posts/domain/repositories/posts_repository.dart';

class UpdatePostUseCases {
  final PostRepositories repositories;

  UpdatePostUseCases(this.repositories);

  Future<Either<Failure, Unit>> call(Post post) async {
    return await repositories.updatePost(post);
  }
}
