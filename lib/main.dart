import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viridis_sonus_app/routes.dart';
import 'package:viridis_sonus_app/services/services.dart';
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
        ChangeNotifierProvider(create: ( _ ) => AuthService())
      ],
      child: MyApp(),
    );
  }
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemeData.lightTheme,
      title: 'Viridis Sonus',
      routes: routes(),
      initialRoute: 'login',
    );
  }
}