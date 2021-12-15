import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class GeolocalizacionService extends ChangeNotifier {

double? _latitud;
double? _longitud;
double? _altitud;
bool _isEnabled = false;

get latitud => _latitud;
get longitud => _longitud;
get altitud => _altitud;

bool get isEnabled => _isEnabled;
set isEnabled(bool value) {
  _isEnabled = value;
  notifyListeners();
}


getPosicion() async {

  bool serviceEnabled;
  LocationPermission locationPermission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();

  if(!serviceEnabled){
    return 'Servicio de Geolocalización deshabilitado';
  }

  locationPermission = await Geolocator.checkPermission();
  if(locationPermission == LocationPermission.denied){
    locationPermission = await Geolocator.requestPermission();
    if(locationPermission== LocationPermission.denied){
      return 'Has denegado los permisos de Geolocalización';
    }
  }

  if (locationPermission == LocationPermission.deniedForever){
    locationPermission = await Geolocator.requestPermission();
    return 'Has denegado los permisos de Geolocalización permanentemente';
  }

  isEnabled = true;

  Position posicionActual = await Geolocator.getCurrentPosition();
  _latitud = posicionActual.latitude;
  _longitud = posicionActual.longitude;

}
}