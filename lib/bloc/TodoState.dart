
part of 'TodoBloc.dart';

abstract class TodoState extends Equatable {}

class TodoInitialState extends TodoState {
  @override
  List<Object> get props => [];
}

class AddStateLoading extends TodoState {
  @override
  List<Object> get props => [];
}

class AddStateSuccessfull extends TodoState {
  @override
  List<Object> get props => [];
}

class DataLoading extends TodoState {
  @override
  List<Object> get props => [];
}

class FetchDataSuccessful extends TodoState {
  List<String> todos;

  FetchDataSuccessful({@required this.todos});

  @override
  List<Object> get props => [todos];
}

class DeleteDataLoading extends TodoState {
  @override
  List<Object> get props => [];
}