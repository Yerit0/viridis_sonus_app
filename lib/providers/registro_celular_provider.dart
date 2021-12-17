import 'dart:async';

import 'package:flutter/material.dart';
import 'package:noise_meter/noise_meter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:viridis_sonus_app/models/models.dart';

class RegistroCelularProvider extends ChangeNotifier{
  bool _isRecording = false;
  StreamSubscription<NoiseReading>? _noiseSubscription;
  late NoiseMeter _noiseMeter;
  late int previousMillis;
  int duracionMinimaDeGrabacion = 20;
  double millis = 0;

  double _correccionRuido = 0.0;
  double reducirRuido = -5.0;

  double maxDB = 0.0;
  double mediaDB = 0.0;

  double? maxima;
  double? media;
  double? minima;
  int claseSonometroId = 1;
  bool interior = false;
  double? latitud;
  double? longitud;
  bool? investigador;

  List<ChartData> chartData = [];

  ChartSeriesController? chartSeriesController;

  bool get isRecording => _isRecording;
  set isRecording(bool value){
    _isRecording = value;
    notifyListeners();
  }

  double get correccionRuido => _correccionRuido;
  set correccionRuido(double value){
    _correccionRuido = value;
    notifyListeners();
  }

  RegistroCelularProvider(){
    _noiseMeter = NoiseMeter(onError);
  }

    obtenerMedia(){
      List<double?> listaSeparada = [];
      List<double?> listaMedia = [];
      double promedioMedia = 0;

      if(chartData.length > 0){
      for (var i = 0; i < chartData.length; i++) {
        listaSeparada.add(chartData[i].maxDB);
        listaMedia.add(chartData[i].meanDB);
      }

      for (var i = 0; i < listaMedia.length; i++) {
        if(listaMedia[i] != null){
          promedioMedia = promedioMedia + listaMedia[i]!;
        }
      }

      promedioMedia = promedioMedia / listaMedia.length;
      listaSeparada.sort();

      maxima = listaSeparada.last;
      media = promedioMedia;
      minima = listaSeparada.first;
      } else {
        return 'No has capturado datos';
      }

    }

    obtenerTiempoDeGrabacion() {
      double tiempo = 0;
      if(chartData.length > 0){
        tiempo = chartData.last.frames;
        if(tiempo < duracionMinimaDeGrabacion){
          return 'Debes grabar mínimo 1 minuto';
        }
      }
    }

    void onData(NoiseReading noiseReading) {
    if (!isRecording) {
      isRecording = true;
    }
    if(!noiseReading.maxDecibel.isNaN && !noiseReading.meanDecibel.isNaN){
      maxDB = noiseReading.maxDecibel + (reducirRuido + correccionRuido);
      mediaDB = noiseReading.maxDecibel;
    }


    millis =((DateTime.now().millisecondsSinceEpoch - previousMillis) / 1000);

    chartData.add(ChartData( maxDB, mediaDB, ((DateTime.now().millisecondsSinceEpoch - previousMillis) / 1000)));
    
    notifyListeners();
  }

  void reset() async {
    chartData.clear();
    maxDB = 0.0;
    mediaDB = 0.0;

    notifyListeners();
  }

  void start() async {
    reset();
    previousMillis = DateTime.now().millisecondsSinceEpoch;
    try {
      _noiseSubscription = _noiseMeter.noiseStream.listen(onData);
    } catch (exception) {
      print(exception);
    }
  }

  void stopRecorder() async {
  try {
    if (_noiseSubscription != null) {
      _noiseSubscription!.cancel();
      _noiseSubscription = null;
    }
    isRecording = false;
  } catch (err) {
    print('stopRecorder error: $err');
  }
  previousMillis = 0;
  }

  void onError(Object error) {
    print(error.toString());
    isRecording = false;
  }

}