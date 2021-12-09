import 'package:flutter/material.dart';
import 'package:viridis_sonus_app/screens/screens.dart';



Map<String, WidgetBuilder> routes(){
  return <String, WidgetBuilder>{
    'splash'    : (BuildContext context) => SplashScreen(),
    'home'      : (BuildContext context) => HomeScreen(),
    'login'     : (BuildContext context) => LoginScreen(),
    'register'  : (BuildContext context) => RegisterScreen(),
  };
}