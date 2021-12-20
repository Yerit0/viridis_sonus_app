import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:viridis_sonus_app/providers/providers.dart';
import 'package:viridis_sonus_app/services/auth_services.dart';
import 'package:viridis_sonus_app/services/services.dart';
import 'package:viridis_sonus_app/utils/widgets/Colors.dart';
import 'package:viridis_sonus_app/utils/widgets/Widgets.dart';

class LoginScreen extends StatelessWidget {

@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: context.width(),
          height: context.height(),
          decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/wa_bg.jpg'), fit: BoxFit.cover)),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                20.height,
                Text("Inicio de Sesión", style: boldTextStyle(size: 24)),
                Container(
                  margin: EdgeInsets.all(16),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                        margin: EdgeInsets.only(top: 55.0),
                        decoration: boxDecorationWithShadow(borderRadius: BorderRadius.circular(30)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            50.height,
                            ChangeNotifierProvider(
                              create: ( _ ) => LoginFormProvider(),
                              child: _LoginForm(),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 100,
                        width: 100,
                        decoration: boxDecorationRoundedWithShadow(30),
                        child: Image.asset(
                          'assets/images/vs_app_logo.png',
                          height: 60,
                          width: 60,
                          fit: BoxFit.cover,
                        ),
                      )
                    ],
                  ),
                ),
                16.height,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    final loginForm = Provider.of<LoginFormProvider>(context);
    
    return Container(
            child: Form(
              key: loginForm.formKey,
              //autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  50.height,
                  Text("Correo Electrónico", style: boldTextStyle(size: 14)),
                  8.height,
                  AppTextField(
                    controller: loginForm.email != '' ? TextEditingController(text: loginForm.email) : null,
                    enabled: !loginForm.isLoading,
                    decoration: inputDecoration(
                      hint: 'Ingresa tu correo electrónico aquí', 
                      prefixIcon: Icons.email_outlined),
                    textFieldType: TextFieldType.EMAIL,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => loginForm.email = value,
                    validator: ( value ) {
                      String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                      RegExp regExp  = new RegExp(pattern);
                      return regExp.hasMatch(value ?? '')
                        ? null
                        : 'Ingrese un correo electrónico valido';
              }
                  ),
                  16.height,
                  Text("Contraseña", style: boldTextStyle(size: 14)),
                  8.height,
                  AppTextField(
                    controller: loginForm.password != '' ? TextEditingController(text: loginForm.password) : null,
                    enabled: !loginForm.isLoading,
                    decoration: inputDecoration(
                      hint: 'Ingresa tu contraseña aquí', 
                      prefixIcon: Icons.lock_outline),
                    suffixIconColor: PrimaryColor,
                    textFieldType: TextFieldType.PASSWORD,
                    isPassword: true,
                    keyboardType: TextInputType.visiblePassword,
                    onChanged: (value) => loginForm.password = value,
                    validator: ( value ) {
                      return ( value != null && value.length >= 6 ) 
                      ? null
                      : 'la Contraseña debe ser de 6 caracteres mínimo';
                    },
                  ),
                  16.height,
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Recordar", style: primaryTextStyle()),
                        Switch(value: loginForm.isActiveSwitch, 
                        onChanged: (value){
                          loginForm.isActiveSwitch = value;
                        }, activeColor: PrimaryColor,),
                      ],
                    ),
                  ),
                  30.height,
                  loginForm.isLoading
                  ? IgnorePointer(
                    ignoring: loginForm.isLoading,
                    child: AppButton(
                      child: CupertinoActivityIndicator(),
                        color: PrimaryColor,
                        textColor: Colors.white,
                        shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        width: context.width(),
                        onTap:(){}
                    ).paddingOnly(left: context.width() * 0.1, right: context.width() * 0.1),
                  )
                  : AppButton(
                      text: "Ingresar",
                      color: PrimaryColor,
                      textColor: Colors.white,
                      shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      width: context.width(),
                      onTap: loginForm.isLoading ? null :() async {
                        FocusScope.of(context).unfocus();

                        final authService = Provider.of<AuthService>(context, listen: false);

                        if(!loginForm.isValidForm()) return;

                        loginForm.isLoading = true;

                        final String? erroMessage = await authService.loginUsuario(loginForm.email, loginForm.password);
                        
                        if (erroMessage == null) {
                          if(!loginForm.isActiveSwitch){loginForm.noRecordarUsuario();}
                          Navigator.pushReplacementNamed(context, 'dashboard');
                        } else {
                          NotificationsService.showSnackbar(erroMessage);
                          loginForm.isLoading = false;
                        }

                      }).paddingOnly(left: context.width() * 0.1, right: context.width() * 0.1),
                  30.height,
                  //Container(
                  //  width: 200,
                  //  child: Row(
                  //    children: [
                  //      Divider(thickness: 2).expand(),
                  //      8.width,
                  //      Text('También con', style: boldTextStyle(size: 16, color: Colors.grey)),
                  //      8.width,
                  //      Divider(thickness: 2).expand(),
                  //    ],
                  //  ),
                  //).center(),
                  //30.height,
                  //Row(
                  //  mainAxisSize: MainAxisSize.min,
                  //  mainAxisAlignment: MainAxisAlignment.center,
                  //  children: [
                  //    Container(
                  //      decoration: boxDecorationRoundedWithShadow(16),
                  //      padding: EdgeInsets.all(16),
                  //      child: Image.asset('images/walletApp/wa_facebook.png', width: 40, height: 40),
                  //    ),
                  //    30.width,
                  //    Container(
                  //      decoration: boxDecorationRoundedWithShadow(16),
                  //      padding: EdgeInsets.all(16),
                  //      child: Image.asset('images/walletApp/wa_google_logo.png', width: 40, height: 40),
                  //    ),
                  //  ],
                  //).center(),
                  //30.height,
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('¿No tienes cuenta?', style: primaryTextStyle(color: Colors.grey)),
                      4.width,
                      Text('Registrate aquí', style: boldTextStyle(color: Colors.black)),
                    ],
                  ).onTap(() {
                    Navigator.pushReplacementNamed(context, 'register');
                  }).center(),
                ],
              ),
            ),
          );
  }
}