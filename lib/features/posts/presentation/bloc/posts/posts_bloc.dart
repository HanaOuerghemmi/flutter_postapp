import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_kraft/core/error/failures.dart';
import 'package:flutter_kraft/features/posts/domaine/entites/post_entity.dart';
import 'package:flutter_kraft/features/posts/domaine/usecases/get_all_posts.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  //get all post usecase
  final GetAllPosts getAllPosts;
  PostsBloc({required this.getAllPosts}) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent) {
        emit(LoadingPostsState());
        //foldState is failure or posts
        final foldState = await getAllPosts();
        emit(_mapFoldState(foldState));
      } else if (event is RefreshPostsEvent) {
        //foldState is failure or posts
        final foldState = await getAllPosts();
        emit(_mapFoldState(foldState));
      }
    });
  }

  PostsState _mapFoldState(Either<Failure, List<PostEntity>> either) {
    return either.fold(
      //left return the state of failure
      (failure) => ErrorPostsState(message: _mapFailureToMessage(failure)),
      //right return the state of all posts
      (posts) => LodedPostsState(posts: posts),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}
