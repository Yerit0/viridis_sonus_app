import 'package:flutter/material.dart';
import 'package:viridis_sonus_app/screens/policy_screen.dart';
import 'package:viridis_sonus_app/screens/screens.dart';

Map<String, WidgetBuilder> routes(){
  return <String, WidgetBuilder>{
    'splash'        : (BuildContext context) => SplashScreen(),
    'home'          : (BuildContext context) => HomeScreen(),
    'login'         : (BuildContext context) => LoginScreen(),
    'register'      : (BuildContext context) => RegisterScreen(),
    'menurapido'    : (BuildContext context) => QuickMenuScreen(),
    'dashboard'     : (BuildContext context) => DashboardScreen(),
    'celular'       : (BuildContext context) => RegistroCelularScreen(),
    'investigador'  : (BuildContext context) => RegistroInvestigadorScreen(),
    'policy'        : (BuildContext context) => PolicyScreen(),
  };
}