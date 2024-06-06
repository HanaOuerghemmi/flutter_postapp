
import 'package:dartz/dartz.dart';
import 'package:flutter_kraft/core/error/failures.dart';
import 'package:flutter_kraft/features/posts/domaine/entites/post_entity.dart';
import 'package:flutter_kraft/features/posts/domaine/repositories/posts-repository.dart';

class AddPost {
  final PostsRepository repository;

  AddPost({required this.repository});
  Future<Either<Failure, Unit>>  call(PostEntity post) async{
    return await repository.addPost(post);
  }

}