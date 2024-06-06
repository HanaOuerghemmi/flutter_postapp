import 'package:dartz/dartz.dart';
import 'package:flutter_kraft/core/error/failures.dart';
import 'package:flutter_kraft/features/posts/domaine/entites/post_entity.dart';

abstract class PostsRepository {
  Future<Either<Failure, List<PostEntity>>> getAllPosts();
  Future<Either<Failure, Unit>> deletePosts(int id);
  Future<Either<Failure, Unit>> updatePost(PostEntity post);
  Future<Either<Failure, Unit>> addPost(PostEntity post);
}
