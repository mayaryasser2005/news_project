import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:news_project/ui/home.dart';
import 'package:permission_handler/permission_handler.dart';

import 'bloc/observer.dart';

bool isConnect = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  final connectionChecker = InternetConnectionChecker();

  final subscription = connectionChecker.onStatusChange.listen(
    (InternetConnectionStatus status) {
      if (status == InternetConnectionStatus.connected) {
        print('Connected to the internet');
        isConnect = true;
      } else {
        print('Disconnected from the internet');
        isConnect = false;
      }
    },
  );
  await repestPermission();
  runApp(const MyApp());
}

Future<bool> repestPermission() async {
  var status = await Permission.storage.request();
  return status.isGranted;
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
