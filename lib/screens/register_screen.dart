import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:viridis_sonus_app/providers/register_form_provider.dart';
import 'package:viridis_sonus_app/screens/login_screen.dart';
import 'package:viridis_sonus_app/services/auth_services.dart';
import 'package:viridis_sonus_app/services/services.dart';
import 'package:viridis_sonus_app/utils/widgets/Colors.dart';
import 'package:viridis_sonus_app/utils/widgets/Widgets.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: context.width(),
        height: context.height(),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/wa_bg.jpg'), fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              50.height,
              Text("Registrar Nueva Cuenta", style: boldTextStyle(size: 24)),
              Container(
                margin: EdgeInsets.all(16),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    Container(
                      width: context.width(),
                      padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                      margin: EdgeInsets.only(top: 55.0),
                      decoration: boxDecorationWithShadow(
                          borderRadius: BorderRadius.circular(30)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ChangeNotifierProvider(
                            create: ( _ ) => RegisterFormProvider(),
                            child: _RegisterForm())
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 100,
                      width: 100,
                      decoration: boxDecorationRoundedWithShadow(30),
                      child: Image.asset(
                        'assets/images/file-document-edit-outline.png',
                        height: 60,
                        width: 60,
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _RegisterForm extends StatelessWidget {
  
  var nombreController = TextEditingController();
  FocusNode nombreFocusNode = FocusNode();


  @override
  Widget build(BuildContext context) {

    final registerForm = Provider.of<RegisterFormProvider>(context);

    return Container(
      child: Form(
        key: registerForm.formKey,
        //autovalidateMode: AutovalidateMode.always,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            50.height,
            Text("Nombres", style: boldTextStyle(size: 14)),
            8.height,
            AppTextField(
              decoration: inputDecoration(
                  hint: 'Ingresa tus nombres aquí',
                  prefixIcon: Icons.person_outline_outlined),
              textFieldType: TextFieldType.NAME,
              keyboardType: TextInputType.name,
              onChanged: (value) => registerForm.nombre = value,
              validator: ( value ) {
                return ( value != null && value.length >= 3 ) 
                ? null
                : 'El Nombre debe ser de 3 caracteres mínimo';
              },
            ),
            16.height,
            Text("Apellido Paterno", style: boldTextStyle(size: 14)),
            8.height,
            AppTextField(
              decoration: inputDecoration(
                  hint: 'Ingresa tu apellido paterno aquí',
                  prefixIcon: Icons.person_outline_outlined),
              textFieldType: TextFieldType.NAME,
              keyboardType: TextInputType.name,
              onChanged: (value) => registerForm.aPaterno = value,
              validator: ( value ) {
                return ( value != null && value.length >= 3 ) 
                ? null
                : 'El Apellido Paterno debe ser de 3 caracteres mínimo';
              },
            ),
            16.height,
            Text("Apellido Materno", style: boldTextStyle(size: 14)),
            8.height,
            AppTextField(
              decoration: inputDecoration(
                  hint: 'Ingresa tu apellido materno aquí',
                  prefixIcon: Icons.person_outline_outlined),
              textFieldType: TextFieldType.NAME,
              keyboardType: TextInputType.name,
              onChanged: (value) => registerForm.aMaterno = value,
              validator: ( value ) {
                return ( value != null && value.length >= 3 ) 
                ? null
                : 'El Apellido Materno debe ser de 3 caracteres mínimo';
              },
            ),
            16.height,      
            Text("Nombre de Usuario", style: boldTextStyle(size: 14)),
            8.height,
            AppTextField(
              decoration: inputDecoration(
                  hint: 'Ingresa tu nombre de usuario aquí',
                  prefixIcon: Icons.person_outline_outlined),
              textFieldType: TextFieldType.NAME,
              keyboardType: TextInputType.name,
              onChanged: (value) => registerForm.nombreUsuario = value,
              errorThisFieldRequired: 'Este campo es obligatorio',
            ),
            16.height,      
            Text("Correo Electrónico", style: boldTextStyle(size: 14)),
            8.height,
            AppTextField(
              decoration: inputDecoration(
                  hint: 'Ingresa tu correo electrónico aquí',
                  prefixIcon: Icons.email_outlined),
              textFieldType: TextFieldType.EMAIL,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) => registerForm.email = value,
              errorInvalidEmail: 'Correo Electrónico inválido',
              errorThisFieldRequired: 'Este campo es obligatorio',
              
            ),
            16.height,
            Text("Contraseña", style: boldTextStyle(size: 14)),
            8.height,
            AppTextField(
              decoration: inputDecoration(
                  hint: 'Ingresa tu nueva contraseña aquí',
                  prefixIcon: Icons.lock_outline),
              suffixIconColor: PrimaryColor,
              textFieldType: TextFieldType.PASSWORD,
              isPassword: true,
              keyboardType: TextInputType.visiblePassword,
              onChanged: (value) => registerForm.password = value,
              validator: ( value ) {
                return ( value != null && value.length >= 6 ) 
                ? null
                : 'la Contraseña debe ser de 6 caracteres mínimo';
              },
              
            ),
            16.height,
            Text("Confirmar Contraseña", style: boldTextStyle(size: 14)),
            8.height,
            AppTextField(
              decoration: inputDecoration(
                  hint: 'Repetir contraseña aquí',
                  prefixIcon: Icons.lock_outline),
              suffixIconColor: PrimaryColor,
              textFieldType: TextFieldType.PASSWORD,
              isPassword: true,
              keyboardType: TextInputType.visiblePassword,
              validator: (value) {
                  if(registerForm.password != value){
                    return 'La contraseña no coincide';
                  }
                  return ( value != null && value.length >= 6 ) 
                    ? null
                    : 'la Contraseña debe ser de 6 caracteres mínimo';
              }
            ),
            30.height,
            AppButton(
                    text: "Registrar Cuenta",
                    color: PrimaryColor,
                    textColor: Colors.white,
                    shapeBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    width: context.width(),
                    onTap: registerForm.isLoading ? null :() async {
                      FocusScope.of(context).unfocus();

                      final authService = Provider.of<AuthService>(context, listen: false);

                      if(!registerForm.isValidForm()) return;

                      final String? erroMessage = await authService.crearUsuario(
                        registerForm.nombre,
                        registerForm.aPaterno,
                        registerForm.aMaterno,
                        registerForm.nombreUsuario,
                        registerForm.email,
                        registerForm.password
                      );

                      if (erroMessage == null) {
                          Navigator.pushReplacementNamed(context, 'login');
                        } else {
                          NotificationsService.showSnackbar(erroMessage);
                          registerForm.isLoading = false;
                        }

                      
                    })
                .paddingOnly(
                    left: context.width() * 0.1, right: context.width() * 0.1),
            30.height,
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('¿Ya tienes una cuenta?',
                    style: primaryTextStyle(color: Colors.grey)),
                4.width,
                Text('Ingresa aquí', style: boldTextStyle(color: Colors.black)),
              ],
            ).onTap(() {
              Navigator.pushReplacementNamed(context, 'login');
            }).center(),
          ],
        ),
      ),
    );
  }
}
