import 'package:exchange_app/view/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'core/bloc_helper/my_bloc_observer.dart';
import 'core/networks/remote/dio_helper.dart';
import 'core/services/services_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // initialize dio helper
  DioHelper.init();
  // initialize Services Locator
  ServicesLocator().init();
  // initialize locObserver
  Bloc.observer = MyBlocObserver();

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
