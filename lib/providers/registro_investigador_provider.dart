import 'package:flutter/material.dart';

class RegistroInvestigadorProvider extends ChangeNotifier {

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  double minima = -1;
  double maxima = -1;
  double media = -1;
  int? claseSonometroId;
  bool? interior;
  double latitud = -33.5111;
  double longitud = -71.6160;
  double altitud = 4.0;
  bool? investigador;

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