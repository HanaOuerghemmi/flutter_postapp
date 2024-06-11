import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kraft/core/error/failures.dart';
import 'package:flutter_kraft/core/messages/message.dart';
import 'package:flutter_kraft/features/posts/domaine/entites/post_entity.dart';
import 'package:flutter_kraft/features/posts/domaine/usecases/add_post.dart';
import 'package:flutter_kraft/features/posts/domaine/usecases/delet_post.dart';
import 'package:flutter_kraft/features/posts/domaine/usecases/update_post.dart';

part 'crud_bloc_event.dart';
part 'crud_bloc_state.dart';

class CrudBlocBloc extends Bloc<CrudBlocEvent, CrudBlocState> {
  final AddPost addPost;
  final DeletePost deletePost;
  final UpdatePost updatePost;

  CrudBlocBloc(
      {required this.addPost,
      required this.deletePost,
      required this.updatePost})
      : super(CrudBlocInitial()) {
    on<CrudBlocEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(LoadingCrudPostState());
        //failure or done message
        final statusMessage = await addPost(event.post);
        emit(
            _mapFoldState(either: statusMessage, message: ADD_SUCCESS_MESSAGE));
      } else if (event is UpdatePostEvent) {
        final statusMessage = await updatePost(event.post);
        emit(_mapFoldState(
            either: statusMessage, message: UPDATE_SUCCESS_MESSAGE));
      } else if (event is DeletePostEvent) {
        final statusMessage = await deletePost(event.postId);
        emit(_mapFoldState(
            either: statusMessage, message: DELETE_SUCCESS_MESSAGE));
      }
    });
  }

  CrudBlocState _mapFoldState(
      {required Either<Failure, Unit> either, required String message}) {
    return either.fold(
      //left return the state of failure
      (failure) => ErrorCrudPostState(message: _mapFailureToMessage(failure)),
      //right return the state of all posts
      (posts) => MessageCrudPostState(message: message),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;

      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}
