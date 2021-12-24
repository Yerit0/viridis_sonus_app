import 'dart:async';

import 'package:flutter/cupertino.dart';
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

class _BuildGrabacionScreen extends StatefulWidget {
  @override
  State<_BuildGrabacionScreen> createState() => _BuildGrabacionScreenState();
}

class _BuildGrabacionScreenState extends State<_BuildGrabacionScreen> {

  @override
  void initState() {
    super.initState();
    Timer.run(() => showInstrucciones(context: context));
  }

  @override
  Widget build(BuildContext context) {
    
    final registroCelular = Provider.of<RegistroCelularProvider>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: [IconButton(
          icon: Icon(Icons.info_outline),
          onPressed: () => showInstrucciones(context: context)
        ),],
        centerTitle: true,
        backgroundColor: Colors.transparent,
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
                35.height,
                Text(
                  'Registrar Medición',
                  style: boldTextStyle(size: 24),
                ),
                10.height,
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
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
                            _resumenData(registroCelular),
                            10.height,
                            _switchButton(registroCelular),
                            10.height,
                            _correccionRuido(registroCelular, context),
                            10.height,
                            _botonesCaptura(context, registroCelular),
                            10.height
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

  Widget _resumenData(RegistroCelularProvider registroCelular) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.grey.withOpacity(0.2)
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          Center(child: Text('Resumen',style: primaryTextStyle(size:16),)),
          5.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(children: [
                Text('Mín'),
                Text(registroCelular.minima == null ? '0.0' : '${registroCelular.minima} dB')
              ],),
              Column(children: [
                Text('Media'),
                Text(registroCelular.media == null ? '0.0' : '${registroCelular.media} dB')
              ],),
              Column(children: [
                Text('Máx'),
                Text(registroCelular.maxima == null ? '0.0' : '${registroCelular.maxima} dB')
              ],),
            ],
          ),
          5.height
        ],
      ),
    );
    }

  Container _correccionRuido(RegistroCelularProvider registroCelular, BuildContext context) {
    return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.2)
                              ),
                            ),
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
                                        }),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
  }

  Container _switchButton(RegistroCelularProvider registroCelular) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.grey.withOpacity(0.2)
        ),
      ),
      child: IgnorePointer(
        ignoring: registroCelular.isRecording,
        child: SwitchListTile(value: registroCelular.interior,
          activeColor: PrimaryColor,
          title: Text('Interior', style: boldTextStyle(size: 18),),
          onChanged: (value){
            registroCelular.interior = value;
          }),
      ),
    );
  }

  Container _chart(RegistroCelularProvider registroCelular) {
    return Container(
      padding: EdgeInsets.only(right: 30),
      height: 190,
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
        //color: Colors.red,
        height: context.height() * 0.32,
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
      IgnorePointer(
        ignoring: registroCelular.isLoading,
        child: AppButton(
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
      ),
      IgnorePointer(
        ignoring: registroCelular.isRecording,
        child: registroCelular.isLoading 
        ?AppButton(
            child: CupertinoActivityIndicator(),
            color: PrimaryColor,
            shapeBorder:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            width: MediaQuery.of(context).size.width * 0.2,
            height: MediaQuery.of(context).size.width * 0.2,
            onTap:(){})
        : AppButton(
            child: Icon(
              Icons.save,
              size: 35.0,),
            color: PrimaryColor,
            shapeBorder:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            width: MediaQuery.of(context).size.width * 0.2,
            height: MediaQuery.of(context).size.width * 0.2,
            onTap: registroCelular.isLoading ? null : () async {
              final usuarioService = Provider.of<UsuarioService>(context, listen: false);
              final registrosService = Provider.of<RegistrosService>(context, listen: false);
              final geolocalizacionService = Provider.of<GeolocalizacionService>(context, listen: false);
              registroCelular.isLoading = true;
              String? errorMessage = registroCelular.obtenerTiempoDeGrabacion();
              if(errorMessage != null){
                NotificationsService.showSnackbar(errorMessage);
                registroCelular.isLoading = false;
              } else {
                errorMessage = registroCelular.obtenerMedia();
                if(errorMessage != null){
                  NotificationsService.showSnackbar(errorMessage);
                  registroCelular.isLoading = false;
                } else {
                  errorMessage = await geolocalizacionService.getPosicion();
                  if(errorMessage != null){
                    NotificationsService.showSnackbar(errorMessage);
                    registroCelular.isLoading = false;
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
                        showADialogCustom(context, onAccept: (context) => { finish(context)},
                        dialogType: DialogType.ACCEPT,
                        positiveText: 'Aceptar',
                        title: '¡Gracias por tu aporte!',
                        barrierDismissible: false,
                        );
                        registroCelular.isLoading = false;
                        
                      } else {
                        showADialogCustom(context, onAccept: (context) {},
                        dialogType: DialogType.DELETE,
                        positiveText: 'Aceptar',
                        title: registroMessage,
                        barrierDismissible: false,
                        );
                        registroCelular.isLoading = false;
                      }
                  }
                }
              }
            }),
      ),
    ],
  );
}

showInstrucciones({required BuildContext context}){
  return showADialogCustom(context,
  title:'Instrucciones',
  subTitle: 'Antes de iniciar con los registros, recuerda:\n\n' 
    '- Las Lecturas deben durar mínimo 30 segundos.\n' 
    '- Debes estar a una distancia de 1.5 metros del suelo.\n'
    '- Debes estar alejado de paredes o superficies.\n'
    '- Procura no tapar el micrófono del teléfono.',
  subtitleAlign: TextAlign.justify,
  positiveText: 'Entendido',
  onAccept: (context){});

}


