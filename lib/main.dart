import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:news_project/ui/home.dart';

import 'bloc/observer.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        HomeScreen.routeNamed:(_) => HomeScreen()
      },
      initialRoute: HomeScreen.routeNamed ,
    );
  }
}
