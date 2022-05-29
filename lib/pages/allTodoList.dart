import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nelson_bloc/bloc/TodoBloc.dart';

class AllTodosList extends StatefulWidget {
  @override
  _AllTodosListState createState() => _AllTodosListState();
}

class _AllTodosListState extends State<AllTodosList> {
  TodoBloc todoBloc;
  @override
  void initState() {
    todoBloc = BlocProvider.of<TodoBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Todo List'),
      ),
      body: BlocBuilder(
        cubit: todoBloc,
        builder: (context, state) {
          if (state is DataLoading) {
            return Container(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(),
            );
          }
          if (state is FetchDataSuccessful) {
            return state.todos.isEmpty ? Text('No todos...') : Container(
              child: ListView.builder(
                itemCount: state.todos.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('${state.todos[index]}'),
                    trailing: GestureDetector(
                      onTap: () {
                        todoBloc.deleteTodo(index: index);
                      },
                      child: Icon(Icons.delete_forever, color: Colors.red,),
                    ),
                  );
                },
              ),
            );
          }
          if (state is AddStateSuccessfull) {
            return Container(
              child: Text('Added successfully...'),
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
