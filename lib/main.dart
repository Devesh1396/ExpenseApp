import 'package:expense_app/Onboard_Ui.dart';
import 'package:expense_app/SignIn_Ui.dart';
import 'package:expense_app/SplashUi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'HomeUI.dart';
import 'bloc/blocmd.dart';

void main() {
  runApp(BlocProvider(
    create: (context) => UserBloc(),
    child: MyApp(),
  ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: HomeUI(),
      debugShowCheckedModeBanner: false,
    );
  }
}
