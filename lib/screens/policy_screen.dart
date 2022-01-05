import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class PolicyScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        height: context.height(),
        width: context.width(),
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/wa_bg.jpg'), fit: BoxFit.cover)
          ),
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Column(
                children: [
                  35.height,
                  Text('Políticas de Privacidad', style: boldTextStyle(size:24),),
                  10.height,
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          width: context.width(),
                          padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                          margin: EdgeInsets.only(top:10.0),
                          decoration: boxDecorationWithShadow(
                            borderRadius: BorderRadius.circular(30)
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              5.height,
                              Container(
                                width: double.infinity,
                                child: Text('Viridus Sonus', style: boldTextStyle(size:18), textAlign: TextAlign.center,)),
                              10.height,
                              Text('Esta política de privacidad rige el uso de la aplicación Viridus Sonus para dispositivos Android creada por Instituto Comercial Marítimo Pacifico Sur.', textAlign: TextAlign.justify,),
                              10.height,
                              Text('¿Qué información recolectamos?', style: boldTextStyle(size:14),),
                              5.height,
                              Text('Recolectamos decibeles de audio capturados con el micrófono del teléfono para determinar la contaminación acústica. \nPara poder aportar con registros debes crear una cuenta personal dentro de la aplicación para luego ingresar y poder generar registros.', textAlign: TextAlign.justify,),
                              15.height,
                              Text('Ubicación en tiempo real', style: boldTextStyle(size:14),),
                              5.height,
                              Text('Esta aplicación requiere de la ubicación en tiempo real al momento de enviar el registro a nuestros servidores. Con esto determinamos la ubicación donde fue generado el registro, una vez enviado el registro, la ubicación no sigue ejecutándose hasta generar un nuevo registro. \nLa ubicación quedará directamente relacionada con el registro enviado a nuestros servidores. con esto se determinará en qué zonas existe contaminación acústica.',textAlign: TextAlign.justify,),
                              15.height,
                              Text('Acceso al micrófono del teléfono', style: boldTextStyle(size:14),),
                              5.height,
                              Text('Esta aplicación requiere de acceso al micrófono del teléfono para poder captar los decibeles de alrededor y generar un listado de datos para análisis estadísticos. Esta aplicación no almacena sonidos, solo datos en decibeles. \nUna vez enviado el registro a nuestros servidores, los datos capturados por el micrófono serán borrados del dispositivo.', textAlign: TextAlign.justify,),
                              15.height,
                              Text('Contacto', style: boldTextStyle(size:14),),
                              5.height,
                              Text('Para más información, por favor contactenos a correo: silvaescobaryeri@gmail.com', textAlign: TextAlign.justify),
                              20.height
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        )
      );
  }
}