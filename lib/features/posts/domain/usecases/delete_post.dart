import 'package:dartz/dartz.dart';
import 'package:projectclean/core/error/failures.dart';
import 'package:projectclean/features/posts/domain/repositories/posts_repository.dart';

class DeletePostUseCases {
  final PostRepositories repositories;

  DeletePostUseCases(this.repositories);

  Future<Either<Failure, Unit>> call(int postId) async {
    return await repositories.deletePost(postId);
  }
}
