import 'package:dartz/dartz.dart';
import 'package:projectclean/core/error/exceptions.dart';
import 'package:projectclean/core/error/failures.dart';
import 'package:projectclean/core/network/network_info.dart';
import 'package:projectclean/features/posts/data/datasources/post_local_data_source.dart';
import 'package:projectclean/features/posts/data/datasources/post_remote_data_source.dart';
import 'package:projectclean/features/posts/data/models/post_model.dart';
import 'package:projectclean/features/posts/domain/entities/post.dart';
import 'package:projectclean/features/posts/domain/repositories/posts_repository.dart';

typedef DeleteOrUpdateOrAddPost = Future<Unit> Function();

class RepositoriesImp implements PostRepositories {
  final LocalDataSources localDataSources;
  final RemoteDataSources remoteDataSources;
  final NetWorkInfo netWorkInfo;

  RepositoriesImp({
    required this.localDataSources,
    required this.remoteDataSources,
    required this.netWorkInfo,
  });

  @override
  Future<Either<Failure, List<Post>>> getAllPost() async {
    if (await netWorkInfo.connection) {
      try {
        final remoteGet = await remoteDataSources.getAllPost();
        localDataSources.saveLocalPost(remoteGet);
        return Right(remoteGet);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localGet = await localDataSources.getLocalPost();
        return Right(localGet);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    PostModels postModels = PostModels(
      title: post.title,
      body: post.body,
    );
    return await _addOrDeleteOrUpdate(() {
      return remoteDataSources.addPost(postModels);
    });
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int postId) async {
    return await _addOrDeleteOrUpdate(() {
      return remoteDataSources.deletePost(postId);
    });
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    PostModels postModels =
        PostModels(title: post.title, body: post.body, id: post.id);
    return await _addOrDeleteOrUpdate(() {
      return remoteDataSources.updatePost(postModels);
    });
  }

  Future<Either<Failure, Unit>> _addOrDeleteOrUpdate(
      DeleteOrUpdateOrAddPost deleteOrUpdateOrAddPost) async {
    if (await netWorkInfo.connection) {
      try {
        await deleteOrUpdateOrAddPost();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }
}
