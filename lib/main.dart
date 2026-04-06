import 'package:flutter/material.dart';
import 'package:sql_flite/addnotes.dart';
import 'package:sql_flite/home.dart';
import 'package:sql_flite/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const Home(),
      routes: {"addnotes": (context) => const AddNotes()},
    );
  }
}
