import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nb_utils/nb_utils.dart';

class LoginFormProvider extends ChangeNotifier {

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  
  String get email {
    return getStringAsync('usuario');
  }
  set email(value){
    setValue('usuario', value);
  }

  String get password{
    return getStringAsync('password');
  }
  set password(value){
    setValue('password', value);
  }

  bool _isLoading = false;

  bool get isActiveSwitch{
    return getBoolAsync('isActiveSwitch');
  }
  set isActiveSwitch(bool value) {
    setValue('isActiveSwitch', value);
    notifyListeners();
  }

  bool get isLoading => _isLoading;
  set isLoading(bool value){
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

  void noRecordarUsuario() async {
    await removeKey('usuario');
    await removeKey('password');
    await removeKey('isActiveSwitch');
  }

}