import 'package:dartz/dartz.dart';
import 'package:flutter_kraft/core/error/failures.dart';
import 'package:flutter_kraft/features/posts/domaine/entites/post_entity.dart';
import 'package:flutter_kraft/features/posts/domaine/repositories/posts-repository.dart';

class GetAllPosts{
  final PostsRepository repository;

  GetAllPosts({required this.repository});
  Future<Either<Failure, List<PostEntity>>> call() async{
    return await repository.getAllPosts();
  }
}