import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viridis_sonus_app/providers/providers.dart';
import 'package:viridis_sonus_app/utils/widgets/Colors.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return _WhileLoadingWidget();

  }
}

class _WhileLoadingWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: PrimaryColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              child: Image(
                image: AssetImage('assets/images/vs_app_logo.png'),
                fit: BoxFit.cover,
                ),
            ),

            CupertinoActivityIndicator(),

            SizedBox(height:50),

            Text('Viridis Sonus te ayudará a identificar tu exposición al ruido, aprendiendo a disminuir su efecto...',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
            ),
            
          ],
        ),
      ),
    );
  }
}