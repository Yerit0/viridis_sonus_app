import 'package:flutter/material.dart';

class RegistroInvestigadorProvider extends ChangeNotifier {

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  double minima = -1;
  double maxima = -1;
  double media = -1;
  int? claseSonometroId;
  bool _interior = false;
  double? latitud;
  double? longitud;
  double altitud = 1.0;
  bool investigador = true;

  bool _isLoading = false;

  bool get interior => _interior;
  set interior(bool value) {
    _interior = value;
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
}