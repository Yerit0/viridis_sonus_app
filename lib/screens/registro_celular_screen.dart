import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:viridis_sonus_app/models/models.dart';
import 'package:viridis_sonus_app/providers/providers.dart';
import 'package:viridis_sonus_app/services/notification_service.dart';
import 'package:viridis_sonus_app/services/services.dart';
import 'package:viridis_sonus_app/utils/widgets/Colors.dart';

class RegistroCelularScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegistroCelularProvider(),
      child: _BuildGrabacionScreen(),
    );
  }
}

class _BuildGrabacionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final registroCelular = Provider.of<RegistroCelularProvider>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        //title: Text('Captura',
        //    style: boldTextStyle(color: Colors.black, size: 20)),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        height: context.height(),
        width: context.width(),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/wa_bg.jpg'), fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Center(
                child: Column(
              children: [
                50.height,
                Text(
                  'Registrar Medición',
                  style: boldTextStyle(size: 24),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        width: context.width(),
                        padding:
                            EdgeInsets.only(left: 16, right: 16, bottom: 16),
                        margin: EdgeInsets.only(top: 10.0),
                        decoration: boxDecorationWithShadow(
                            borderRadius: BorderRadius.circular(30)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            16.height,
                            _tituloCaptura(registroCelular),
                            _radialGauge(context, registroCelular),
                            _chart(registroCelular),
                            Divider(thickness: 3.0),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Corrección de dB'),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      
                                      IgnorePointer(
                                        ignoring: registroCelular.isRecording,
                                        child: AppButton(
                                          padding: EdgeInsets.symmetric(vertical: 5.0),
                                          child: Icon(Icons.remove),
                                          color: PrimaryColor,
                                          textColor: Colors.white,
                                          shapeBorder: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30)),
                                          onTap:(){
                                            if(registroCelular.correccionRuido > -15){
                                              registroCelular.correccionRuido --;
                                            }
                                            
                                            print(registroCelular.correccionRuido);
                                          }),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        width: context.width()*0.22,
                                        child: Text('${registroCelular.correccionRuido}dB', 
                                          style: boldTextStyle(size: 22, color: registroCelular.correccionRuido > 0 ? Colors.green : registroCelular.correccionRuido < 0 ? Colors.red : null))),
                                      IgnorePointer(
                                        ignoring: registroCelular.isRecording,
                                        child: AppButton(
                                          padding: EdgeInsets.symmetric(vertical: 5.0),
                                          child:Icon(Icons.add),
                                          color: PrimaryColor,
                                          textColor: Colors.white,
                                          shapeBorder: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30)),
                                          onTap:(){
                                            if(registroCelular.correccionRuido < 15){
                                              registroCelular.correccionRuido ++;
                                            }
                                            print(registroCelular.correccionRuido);
                                          }),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Divider(thickness: 3.0),
                            _botonesCaptura(context, registroCelular),
                            30.height
                          ],
                        ),
                      ),
                      
                    ],
                  ),
                ),
                
              ],
            )),
          ),
        ),
      ),
    );
  }

  Container _chart(RegistroCelularProvider registroCelular) {
    return Container(
      height: 200,
      child: SfCartesianChart(
        plotAreaBorderWidth: 0,
        primaryXAxis: NumericAxis(
          title: AxisTitle(text: 'Segundos'),
          //con minimum actualizas el Chart en tiempo real
          minimum: registroCelular.isRecording ? registroCelular.millis - 10 : null,
          majorGridLines: const MajorGridLines(width: 0)),
        primaryYAxis: NumericAxis(
          title: AxisTitle(text: 'dB'),
          minimum: 0,
          maximum: 100,
          axisLine: const AxisLine(width: 0),
          majorTickLines: const MajorTickLines(size: 0)),
        series: 
        <LineSeries<ChartData, double>>[
          LineSeries<ChartData, double>(
            onRendererCreated: (ChartSeriesController controller){
              registroCelular.chartSeriesController = controller;
            },
              dataSource: registroCelular.chartData,
              xAxisName: 'Time',
              yAxisName: 'dB',
              name: 'dB values over time',
              xValueMapper: (ChartData value, _) => value.frames,
              yValueMapper: (ChartData value, _) => value.maxDB,
              animationDuration: 0),
        ],
      ),);
  } 

  Container _radialGauge(BuildContext context, RegistroCelularProvider registroCelular) {
    return Container(
      height: context.height() * 0.30,
        child: SfRadialGauge(
            enableLoadingAnimation: true,
            animationDuration: 1000,
            axes: <RadialAxis>[
          RadialAxis(minimum: 0, maximum: 90, ranges: <GaugeRange>[
            GaugeRange(startValue: 0, endValue: 20, color: Colors.lightGreen),
            GaugeRange(startValue: 20, endValue: 55, color: Colors.green),
            GaugeRange(startValue: 55, endValue: 65, color: Colors.orange),
            GaugeRange(startValue: 65, endValue: 75, color: Colors.red),
            GaugeRange(startValue: 75, endValue: 90, color: Colors.purple)
          ], pointers: <GaugePointer>[
            NeedlePointer(
              value: registroCelular.isRecording
                  ? registroCelular.maxDB.toString() == 'NaN'
                      ? 0.0
                      : registroCelular.maxDB
                  : 00.0,
            )
          ], annotations: <GaugeAnnotation>[
            GaugeAnnotation(
                widget: Container(
                    child: Text(
                        registroCelular.isRecording
                            ? registroCelular.maxDB.toString() == 'NaN'
                                ? 0.0.toString()
                                : registroCelular.maxDB.toStringAsFixed(2)
                            : 00.0.toString(),
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold))),
                angle: 90,
                positionFactor: 0.5)
          ])
        ]));
  }

  Widget _tituloCaptura(RegistroCelularProvider registroCelular) {
    if (registroCelular.isRecording) if (registroCelular.maxDB < 55 &&
        registroCelular.maxDB > 1)
      return Text('BUENO', style: TextStyle(color: Colors.green));
    else if (registroCelular.maxDB < 65 && registroCelular.maxDB > 50)
      return Text('ACEPTABLE', style: TextStyle(color: Colors.orange));
    else if (registroCelular.maxDB < 75 && registroCelular.maxDB > 65)
      return Text('INACEPTABLE', style: TextStyle(color: Colors.red));
    else if (registroCelular.maxDB > 75)
      return Text('RIESGOZO', style: TextStyle(color: Colors.purple));
    else if (registroCelular.maxDB.toString() == 'NaN') Text('CALIBRANDO');

    return Text('Esperando');
  }
}

Widget _botonesCaptura(
    BuildContext context, RegistroCelularProvider registroCelular) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      AppButton(
          child: Icon(
            registroCelular.isRecording ? Icons.stop : Icons.play_arrow,
            size: 35.0,
          ),
          color: registroCelular.isRecording ? SecundaryColor : PrimaryColor,
          shapeBorder:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          width: MediaQuery.of(context).size.width * 0.2,
          height: MediaQuery.of(context).size.width * 0.2,
          onTap: () {
            registroCelular.isRecording
                ? registroCelular.stopRecorder()
                : registroCelular.start();
          }),
      //IgnorePointer(
      //  ignoring: registroCelular.isRecording,
      //  child: AppButton(
      //      child: Icon(
      //        Icons.replay_outlined,
      //        size: 35.0,
      //      ),
      //      color: PrimaryColor,
      //      shapeBorder:
      //          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      //      width: MediaQuery.of(context).size.width * 0.2,
      //      height: MediaQuery.of(context).size.width * 0.2,
      //      onTap: () {
      //        registroCelular.reset();
      //      }),
      //),
      IgnorePointer(
        ignoring: registroCelular.isRecording,
        child: AppButton(
            child: Icon(
              Icons.save,
              size: 35.0,
            ),
            color: PrimaryColor,
            shapeBorder:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            width: MediaQuery.of(context).size.width * 0.2,
            height: MediaQuery.of(context).size.width * 0.2,
            onTap: () async {
              final usuarioService = Provider.of<UsuarioService>(context, listen: false);
              final registrosService = Provider.of<RegistrosService>(context, listen: false);
              final geolocalizacionService = Provider.of<GeolocalizacionService>(context, listen: false);
              
              String? errorMessage = registroCelular.obtenerTiempoDeGrabacion();
              if(errorMessage != null){
                NotificationsService.showSnackbar(errorMessage);
              } else {
                errorMessage = registroCelular.obtenerMedia();
                if(errorMessage != null){
                  NotificationsService.showSnackbar(errorMessage);
                } else {
                  errorMessage = await geolocalizacionService.getPosicion();
                  if(errorMessage != null){
                    NotificationsService.showSnackbar(errorMessage);
                  } else {
                    registroCelular.latitud = geolocalizacionService.latitud;
                    registroCelular.longitud = geolocalizacionService.longitud;
                    registroCelular.investigador = usuarioService.infoUsuario!.roles.contains('Investigador') ? true : false;

                    final String? registroMessage = await registrosService.crearRegistro(
                      registroCelular.minima!, 
                      registroCelular.maxima!, 
                      registroCelular.media!, 
                      registroCelular.claseSonometroId, 
                      registroCelular.interior, 
                      registroCelular.latitud!, 
                      registroCelular.longitud!, 
                      registroCelular.investigador!);

                      if(registroMessage == null ){
                        NotificationsService.showSnackbar('Registro Creado');
                        Navigator.pop(context);
                      } else {
                        NotificationsService.showSnackbar(registroMessage);
                      }
                  }
                }
              }
              //_mostrarAlerta(context);
            }),
      ),
    ],
  );
}

void _mostrarAlerta(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Titulo',
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Mensaje de la caja de alerta'),
              SizedBox(
                height: 30.0,
              ),
              FlutterLogo(size: 100.0),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(), child: Text('Ok'))
          ],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        );
      });
}
