part of 'crud_bloc_bloc.dart';

sealed class CrudBlocEvent extends Equatable {
  const CrudBlocEvent();

  @override
  List<Object> get props => [];
}
class AddPostEvent extends CrudBlocEvent {
  final PostEntity post;

  AddPostEvent({required this.post});
  
  @override
  List<Object> get props => [post];
}

class UpdatePostEvent extends CrudBlocEvent {
  final PostEntity post;

  UpdatePostEvent({required this.post});
  
  @override
  List<Object> get props => [post];
}


class DeletePostEvent extends CrudBlocEvent {
  final int postId;

  DeletePostEvent({required this.postId});
  
  @override
  List<Object> get props => [postId];
}