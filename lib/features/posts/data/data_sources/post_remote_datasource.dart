import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_kraft/core/error/exceptions.dart';
import 'package:flutter_kraft/features/posts/data/model/post_model.dart';
import 'package:http/http.dart' as http;

const BASE_URL = "https://jsonplaceholder.typicode.com";

abstract class PostRemoteDatasource {
  Future<List<PostModel>> getAllPosts();
  Future<Unit> addPosts(PostModel post);
  Future<Unit> updatePosts(PostModel post);
  Future<Unit> deletePosts(int postId);
}

class PostsRepositoryImpl implements PostRemoteDatasource {
  final http.Client client;

  PostsRepositoryImpl({required this.client});

  @override
  Future<List<PostModel>> getAllPosts() async {
    final response = await client.get(
      Uri.parse(BASE_URL + '/posts/'),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      final List decodedJson = json.decode(response.body) as List;
      final List<PostModel> postModels = decodedJson
          .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();

      return postModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addPosts(PostModel post) async {
    final body = {
      "title": post.title,
      "body": post.body,
    };
    final response =
        await client.post(Uri.parse(BASE_URL + "/posts/"), body: body);

    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePosts(int postId) async {
    final response = await client.delete(
      Uri.parse(BASE_URL + "/posts/${postId.toString()}"),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePosts(PostModel post) async {
    final postId = post.id.toString();
    final body = {
      "title": post.title,
      "body": post.body,
    };
    final response = await client.patch(
      Uri.parse(BASE_URL + "/posts/$postId"),
      body: body,
    );
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
