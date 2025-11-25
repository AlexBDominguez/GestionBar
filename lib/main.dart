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
    final homeViewmodel = HomeViewmodel();
    return ChangeNotifierProvider(
      create: (context) => HomeViewmodel(),
      child: MaterialApp(
        title: 'Gestion Bar',
        theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 245, 142, 57),
        ),
        home: MyHomePage(title: 'Cervecería Folks', homeViewmodel: homeViewmodel),
      ),
    );
  }
}