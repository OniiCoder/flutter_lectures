import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nelson_bloc/bloc/TodoBloc.dart';
import 'package:nelson_bloc/pages/allTodoList.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController textController = TextEditingController();

  TodoBloc todoBloc;

  @override
  void initState() {
    todoBloc = BlocProvider.of<TodoBloc>(context);
    todoBloc.fetchTodos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List App'),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener(
            cubit: todoBloc,
            listener: (context, state) {
              if (state is AddStateSuccessfull) {
                textController.clear();
                SnackBar(content: Text('Added successfully...'),);
              }
              return SizedBox.shrink();
            },
          )
        ],
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              TextField(
                controller: textController,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlatButton(
                    color: Colors.blue,
                    onPressed: () {
                      if (textController.text.isNotEmpty) {
                        todoBloc.addTodo(todoText: textController.text);
                      }
                    },
                    child: Text(
                      'Add',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  FlatButton(
                    color: Colors.blue,
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AllTodosList())),
                    child: Text(
                      'All Todos',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
              BlocBuilder(
                cubit: todoBloc,
                builder: (context, state) {
                  if (state is DataLoading) {
                    return IntrinsicHeight(
                      child: Container(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  if (state is FetchDataSuccessful) {
                    return state.todos.isEmpty ? Text('No todos...') : Expanded(child: Container(
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
                    ));
                  }
                  if (state is AddStateSuccessfull) {
                    return Container(
                      child: Text('Added successfully...'),
                    );
                  }
                  return SizedBox.shrink();
                },
              )

            ],
          ),
        ),
      ),
    );
  }
}
