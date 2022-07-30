import 'package:books/view/home_screen.dart';
import 'package:books/view_model/books_view_model.dart';
import 'package:books/view_model/form_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BooksViewModel()),
        ChangeNotifierProvider(create: (_) => FormViewModel())

      ],
      child: MaterialApp(
        title: 'Books App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: 'home',
        routes: {
          'home' : (_) => const HomePage()
        },
      ),
    );
  }
}
