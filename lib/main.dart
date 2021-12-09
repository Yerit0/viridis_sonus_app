import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viridis_sonus_app/routes.dart';
import 'package:viridis_sonus_app/screens/home_screen.dart';
import 'package:viridis_sonus_app/utils/theme/AppTheme.dart';

void main() => runApp(AppState());


// Dejamos en la instancia mas alta de la aplicacion
// Los distintos servicios a consumir
// Servicios alojados en la carpeta *Services*
class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [

      ],
      child: MyApp(),
    );
  }
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppThemeData.lightTheme,
      title: 'Viridis Sonus',
      routes: routes(),
      home: HomeScreen()
    );
  }
}