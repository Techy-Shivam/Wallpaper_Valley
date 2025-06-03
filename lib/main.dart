import 'package:flutter/material.dart';
import 'package:wallpaper_app/splash_screen.dart';
import 'package:wallpaper_app/views/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      title: 'Wallpaper Whiz',
      home: const Home(),
    );
  }
}
