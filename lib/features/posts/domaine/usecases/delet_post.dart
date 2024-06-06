import 'package:dartz/dartz.dart';
import 'package:flutter_kraft/core/error/failures.dart';
import 'package:flutter_kraft/features/posts/domaine/repositories/posts-repository.dart';

class DeletePost {
  final PostsRepository repository;

  DeletePost({required this.repository});
  Future<Either<Failure, Unit>>  call(int postId) async{
    return await repository.deletePosts(postId);
  }

}