import 'package:flutter/material.dart';

class RegisterFormProvider extends ChangeNotifier {

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  String nombre     = '';
  String aPaterno   = '';
  String aMaterno   = '';
  String email      = '';
  String password   = '';
  String rePassword = '';
  
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  set isLoading(bool value){
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}