part of 'crud_bloc_bloc.dart';

sealed class CrudBlocState extends Equatable {
  const CrudBlocState();
  
  @override
  List<Object> get props => [];
}

final class CrudBlocInitial extends CrudBlocState {}

class LoadingCrudPostState extends CrudBlocState{

}

class ErrorCrudPostState extends CrudBlocState{
  final String message;

  ErrorCrudPostState({required this.message});
   @override
  List<Object> get props => [message];
} 

class MessageCrudPostState extends CrudBlocState{
  final String message;

  MessageCrudPostState({required this.message});
   @override
  List<Object> get props => [message];
} 