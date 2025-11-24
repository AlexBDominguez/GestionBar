import 'package:flutter/material.dart';
import 'view/home_view.dart';
import 'package:provider/provider.dart';
import 'viewmodel/home_viewmodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewmodel(),
      child: MaterialApp(
        title: 'Gestion Bar',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Gestion Bar Home Page'),
      ),
    );
  }
}