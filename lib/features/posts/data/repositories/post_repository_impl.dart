import 'package:dartz/dartz.dart';
import 'package:flutter_kraft/core/error/exceptions.dart';
import 'package:flutter_kraft/core/error/failures.dart';
import 'package:flutter_kraft/core/network/network_info.dart';
import 'package:flutter_kraft/features/posts/data/data_sources/post_local_datasource.dart';
import 'package:flutter_kraft/features/posts/data/data_sources/post_remote_datasource.dart';
import 'package:flutter_kraft/features/posts/data/model/post_model.dart';
import 'package:flutter_kraft/features/posts/domaine/entites/post_entity.dart';
import 'package:flutter_kraft/features/posts/domaine/repositories/posts-repository.dart';
typedef Future<Unit> returnPost();
class PostsRepositoryImpl implements PostsRepository {
  final PostRemoteDatasource remoteDatasource;
  final PostLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PostsRepositoryImpl(
      {required this.remoteDatasource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<PostEntity>>> getAllPosts() async {
    await localDataSource.getCachedPosts();
    final isDeviceConnected = await networkInfo.isConnected;

    /// ? device have network connection

    if (isDeviceConnected) {
      try {
        final remotePosts = await remoteDatasource.getAllPosts();
        localDataSource.cachePosts(remotePosts);
        return right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    }

    /// ? device haven't network connection
    else {
      try {
        final localPosts = await localDataSource.getCachedPosts();
        return right(localPosts);
      } on ServerException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(PostEntity post) async{

    final PostModel postModel = PostModel(
      id: post.id, title: post.title, body: post.body
      );
    return await _getMessage(
      function:() {
        return remoteDatasource.addPosts(postModel);
        }
      );
  }


  @override
  Future<Either<Failure, Unit>> updatePost(PostEntity post)async  {
    final PostModel postModel = PostModel(
      id: post.id, title: post.title, body: post.body
      );
    return await _getMessage(
      function:() {
        return remoteDatasource.updatePosts(postModel);
        }
      );
  }

  @override
  Future<Either<Failure, Unit>> deletePosts(int id) async {

    return await _getMessage(
      function:() {
        return remoteDatasource.deletePosts(id);
        }
      );
  }




  Future<Either<Failure, Unit>> _getMessage(
   {  
    required  returnPost function} ) async {
          final isDeviceConnected = await networkInfo.isConnected;
    if (isDeviceConnected){
      try{
         await function();
          return Right(unit);
      } on ServerException{
        return Left(ServerFailure());
      }
    }
       /// ? device haven't network connection
    else{
        return Left(OfflineFailure());
    }
  }
}
