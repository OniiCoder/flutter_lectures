import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nelson_bloc/bloc/TodoBloc.dart';
import 'package:nelson_bloc/pages/Home.dart';

void main() {
  runApp(MultiBlocProvider(
      providers: [
        BlocProvider<TodoBloc>(create: (BuildContext context) => TodoBloc())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home(),
      )));
}
