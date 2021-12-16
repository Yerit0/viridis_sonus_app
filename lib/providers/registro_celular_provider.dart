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
  double millis = 0;

  double correccionRuido = 0.0;
  double reducirRuido = -5.0;

  double maxDB = 0.0;
  double mediaDB = 0.0;

  List<ChartData> chartData = [];
  List<ChartData> liveChartData = [];

  ChartSeriesController? chartSeriesController;

  bool get isRecording => _isRecording;
  set isRecording(bool value){
    _isRecording = value;
    notifyListeners();
  }

  RegistroCelularProvider(){
    _noiseMeter = NoiseMeter(onError);
  }
    void onData(NoiseReading noiseReading) {
    if (!isRecording) {
      isRecording = true;
    }
    maxDB = noiseReading.maxDecibel + reducirRuido;
    mediaDB = noiseReading.maxDecibel;

    millis =((DateTime.now().millisecondsSinceEpoch - previousMillis) / 1000);

    chartData.add(ChartData( maxDB, mediaDB, ((DateTime.now().millisecondsSinceEpoch - previousMillis) / 1000)));
    liveChartData.add(ChartData( maxDB, mediaDB, ((DateTime.now().millisecondsSinceEpoch - previousMillis) / 1000)));

    if(liveChartData.length == 20) {
      liveChartData.removeAt(0);
      chartSeriesController?.updateDataSource(
          addedDataIndexes: <int>[chartData.length - 1],
          removedDataIndexes: <int>[0],
      );
      
    } else {
      chartSeriesController?.updateDataSource(
      addedDataIndexes: <int>[chartData.length - 1],
      );
    }
    notifyListeners();
  }

  void reset() async {
    chartData = [];
    maxDB = 0.0;
    mediaDB = 0.0;

    notifyListeners();
  }

  void start() async {
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
  chartData.clear();
  liveChartData.clear();
  }

  void onError(Object error) {
    print(error.toString());
    isRecording = false;
  }

}