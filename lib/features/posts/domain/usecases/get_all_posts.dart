import 'package:dartz/dartz.dart';
import 'package:projectclean/core/error/failures.dart';
import 'package:projectclean/features/posts/domain/entities/post.dart';
import 'package:projectclean/features/posts/domain/repositories/posts_repository.dart';

class GetAllPostUseCase {
  final PostRepositories repositories;

  GetAllPostUseCase(this.repositories);

  Future<Either<Failure, List<Post>>> call() async {
    return await repositories.getAllPost();
  }
}
