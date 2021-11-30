import 'package:flutter/material.dart';
import 'package:viridis_sonus_app/routes.dart';
import 'package:viridis_sonus_app/screens/home_screen.dart';
import 'package:viridis_sonus_app/utils/theme/AppTheme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppThemeData.lightTheme,
      title: 'Material App',
      routes: routes(),
      home: HomeScreen()
    );
  }
}