import 'package:flutter_kraft/features/posts/domaine/entites/post_entity.dart';

class PostModel extends PostEntity{
  PostModel({required  int id, required String title, required String body})
  
  : super(id: id, title: title, body: body);
 
  factory PostModel.fromJson(Map<String, dynamic> json){
    return PostModel(
      id: json['id'],
       title: json['title'], 
       body: json['body']
       );
  }
   Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'body': body};
  }
}