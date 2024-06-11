part of 'posts_bloc.dart';

sealed class PostsState extends Equatable {
  const PostsState();
  
  @override
  List<Object> get props => [];
}

final class PostsInitial extends PostsState {}
final class LoadingPostsState extends PostsState {}
final class LodedPostsState extends PostsState {
final List<PostEntity> posts;

  LodedPostsState({required this.posts});
 @override
  List<Object> get props => [posts];


}
final class ErrorPostsState extends PostsState {
  final String message;

  ErrorPostsState({required this.message});
   @override
  List<Object> get props => [message];
}
