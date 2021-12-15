import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:viridis_sonus_app/utils/widgets/Colors.dart';


class RegistroCelularScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('Captura', style: boldTextStyle(color: Colors.black, size: 20)),
          centerTitle: true,
          elevation: 0.0,
          brightness: Brightness.dark,
        ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Center(
          child: Column(
            children: [
              _radialGauge(),
              Divider(thickness:  3.0),
              _botonesCaptura(context)
            ],
          )
            ),
        ),
      ),
    );
  }
}

Widget _radialGauge() { 

  return Container(
    child: SfRadialGauge(
      enableLoadingAnimation: true,
      animationDuration: 1000,
          axes: <RadialAxis>[
            RadialAxis(minimum: 0, maximum: 150,
            ranges: <GaugeRange>[
              GaugeRange(startValue: 0, endValue: 50, color:Colors.green),
              GaugeRange(startValue: 50,endValue: 100,color: Colors.orange),
              GaugeRange(startValue: 100,endValue: 150,color: Colors.red)],
            pointers: <GaugePointer>[
              NeedlePointer(value: 0)],
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(widget: Container(child: 
                 Text('0.0',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold))),
                 angle: 90, positionFactor: 0.5
              )]
          )])
      );
}

Widget _botonesCaptura(BuildContext context) {

  bool _isRecording = false;

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      AppButton(
        child: Icon(Icons.play_arrow, size: 35.0,),
        color: PrimaryColor,
        shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        width: MediaQuery.of(context).size.width*0.2,
        height: MediaQuery.of(context).size.width*0.2,
        onTap: (){}
      ),
      AppButton(
        child: Icon(Icons.replay_outlined, size: 35.0,),
        color: PrimaryColor,
        shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        width: MediaQuery.of(context).size.width*0.2,
        height: MediaQuery.of(context).size.width*0.2,
        onTap: (){}
      ),
      AppButton(
        child: Icon(Icons.save, size: 35.0,),
        color: PrimaryColor,
        shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        width: MediaQuery.of(context).size.width*0.2,
        height: MediaQuery.of(context).size.width*0.2,
        onTap: (){_mostrarAlerta(context);}
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
          title: Text('Titulo', textAlign: TextAlign.center,),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Mensaje de la caja de alerta'),
              SizedBox(height: 30.0,),
              FlutterLogo( size: 100.0),
            ],
          ),
          actions: [
                 TextButton(
                    onPressed: () => Navigator.of(context).pop(), 
                    child: Text('Ok')
                    )
            ],
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        );
      });
  }