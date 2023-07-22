import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:sudoku_solver/home_screen.dart';
import 'package:sudoku_solver/initial_bindings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      initialBinding: InitialBindings(),
      home: const HomeScreen(),
    );
  }
}
