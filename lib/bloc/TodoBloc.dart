
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'TodoState.dart';

class TodoBloc extends Cubit<TodoState> {
  TodoBloc() : super(TodoInitialState());
  List<String> todoListInMemory = ['Nelson', 'Akonta', 'Ekuma'];

  Future<void> addTodo({ String todoText }) async {
    emit(DataLoading());
    todoListInMemory.add(todoText);
    await Future.delayed(Duration(seconds: 3));
    emit(AddStateSuccessfull());
    await Future.delayed(Duration(seconds: 2));
    emit(FetchDataSuccessful(todos: todoListInMemory));
  }

  Future<void> fetchTodos() async {
    emit(DataLoading());
    await Future.delayed(Duration(seconds: 3));
    emit(FetchDataSuccessful(todos: todoListInMemory));
  }

  Future<void> deleteTodo({ int index }) async {
    emit(DataLoading());
    todoListInMemory.removeAt(index);
    await Future.delayed(Duration(seconds: 3));
    emit(FetchDataSuccessful(todos: todoListInMemory));
  }

}