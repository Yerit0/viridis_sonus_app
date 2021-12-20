import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:viridis_sonus_app/providers/registro_investigador_provider.dart';
import 'package:viridis_sonus_app/services/services.dart';
import 'package:viridis_sonus_app/services/sonometro_services.dart';
import 'package:viridis_sonus_app/utils/widgets/Colors.dart';
import 'package:viridis_sonus_app/utils/widgets/Widgets.dart';

class RegistroInvestigadorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          //title: Text('Captura', style: boldTextStyle(color: Colors.black, size: 20)),
          centerTitle: true,
          elevation: 0.0,),
        body: Container(
            height: context.height(),
            width: context.width(),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/wa_bg.jpg'),
                  fit: BoxFit.cover),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  50.height,
                  Text('Registrar medición', style: boldTextStyle(size: 24)),
                  Container(
                    margin: EdgeInsets.all(16),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                      width: context.width(),
                      padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                      margin: EdgeInsets.only(top: 55.0),
                      decoration: boxDecorationWithShadow(
                          borderRadius: BorderRadius.circular(30)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ChangeNotifierProvider(
                            create: ( _ ) => RegistroInvestigadorProvider(),
                            child: _RegistrarSonidoForm())
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 100,
                      width: 100,
                      decoration: boxDecorationRoundedWithShadow(30),
                      child: Image.asset(
                        'assets/images/file-document-edit-outline.png',
                        height: 60,
                        width: 60,
                        fit: BoxFit.cover,
                      ),
                    )
                      ],
                    ),
                  ),
                  SizedBox(height: 16,)
                ],
              ))
            )
          );
  }
}

class _RegistrarSonidoForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final registroInvestigador = Provider.of<RegistroInvestigadorProvider>(context);
    final sonometroService = Provider.of<SonometroService>(context);

    
    return IgnorePointer(
      ignoring: registroInvestigador.isLoading,
      child: Container(
        child: Form(
          key: registroInvestigador.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              50.height,
              Text("Mínima", style: boldTextStyle(size: 14)),
              8.height,
              AppTextField(
                //enabled: !registroInvestigadorProvider.isLoading,
                decoration: inputDecoration(
                    hint: 'Ingresa la mínima aquí',
                    prefixIcon: Icons.speed_outlined),
                textFieldType: TextFieldType.NAME,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
                ],
                onChanged: (value) {
                  if(double.tryParse(value) != null){
                    registroInvestigador.minima = double.parse(value);
                  }
                },
                validator: ( value ) {
                  return ( value != null && value.length >= 1 ) 
                  ? null
                  : 'Este campo es obligatorio';
                },
              ),
              16.height,
              Text("Media", style: boldTextStyle(size: 14)),
              8.height,
              AppTextField(
                //enabled: !registroInvestigadorProvider.isLoading,
                decoration: inputDecoration(
                    hint: 'Ingresa la media aquí',
                    prefixIcon: Icons.speed_outlined),
                textFieldType: TextFieldType.NAME,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
                ],
                onChanged: (value) {
                  if(double.tryParse(value) != null){
                    registroInvestigador.media = double.parse(value);
                  }
                },
                validator: ( value ) {
                  return ( value != null && value.length >= 1 ) 
                  ? null
                  : 'Este campo es obligatorio';
                },
              ),
              16.height,
              Text("Máxima", style: boldTextStyle(size: 14)),
              8.height,
              AppTextField(
                //enabled: !registroInvestigadorProvider.isLoading,
                decoration: inputDecoration(
                    hint: 'Ingresa la máxima aquí',
                    prefixIcon: Icons.speed_outlined),
                textFieldType: TextFieldType.NAME,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
                ],
                onChanged: (value) {
                  if(double.tryParse(value) != null){
                    registroInvestigador.maxima = double.parse(value);
                  }
                },
                validator: ( value ) {
                  return ( value != null && value.length >= 1 ) 
                  ? null
                  : 'Este campo es obligatorio';
                },
              ),
              16.height,
              Text('Sonómetro', style: boldTextStyle( size: 14)),
              8.height,
              DropdownButtonFormField(              
                  isExpanded: true,
                  decoration: inputDecoration(hint: "Selecciona un Sonómetro"),
                  items: sonometroService.listadoSonometro.map((sonometroItems) {
                    return DropdownMenuItem<String>(
                      value: sonometroItems.id.toString(),
                      child: Text(sonometroItems.descripcion, style: secondaryTextStyle()),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    if(value != null){
                      registroInvestigador.claseSonometroId = int.parse(value);
                    }
                  },
                  validator: (value) {
                    return value != null
                    ? null
                    : 'Selecciona un sonómetro';
                  },
                ),

              16.height,
                  Container(              
                    margin: EdgeInsets.only(bottom: 5, top: 10),
                    child: Card(                  
                      color: PrimaryColor.withOpacity(0.04),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(
                          color: Colors.grey.withOpacity(0.2),
                          width: 1.0
                          )
                        ),
                      elevation: 0,
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          unselectedWidgetColor: PrimaryColor,
                        ),
                        child: CheckboxListTile(
                          checkColor: Colors.white,
                          activeColor: PrimaryColor,
                          value: registroInvestigador.interior,
                          onChanged: (value) {
                            registroInvestigador.interior = value!;
                          },
                          title: Text(
                            'Interior',
                            style: TextStyle(fontSize: textSecondarySizeGlobal, color: textSecondaryColorGlobal),
                          ),
                        ),
                      ),
                    ),
                  ),
              30.height,
              registroInvestigador.isLoading
              ? AppButton(
                child: const CupertinoActivityIndicator(),
                color: PrimaryColor,
                shapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
                  width: context.width(),
                  onTap:(){}
                  ).paddingOnly(
                      left: context.width() * 0.1, right: context.width() * 0.1)
              : AppButton(
                text: "Registrar Medición",
                color: PrimaryColor,
                textColor: Colors.white,
                shapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
                  width: context.width(),
                  onTap: registroInvestigador.isLoading ? null :() async {
                    FocusScope.of(context).unfocus();
                    final registrosService = Provider.of<RegistrosService>(context, listen: false);
                    final geolocalizacionService = Provider.of<GeolocalizacionService>(context, listen: false);
                        //final authService = Provider.of<AuthService>(context, listen: false);
                    if(!registroInvestigador.isValidForm()) return;
                    registroInvestigador.isLoading = true;
                    final String? erroMessage = await geolocalizacionService.getPosicion();
                    if(erroMessage == null){
                      registroInvestigador.latitud = geolocalizacionService.latitud;
                      registroInvestigador.longitud = geolocalizacionService.longitud;

                      final String? registroMessage = await registrosService.crearRegistro(
                        registroInvestigador.minima, 
                        registroInvestigador.maxima, 
                        registroInvestigador.media, 
                        registroInvestigador.claseSonometroId!, 
                        registroInvestigador.interior, 
                        registroInvestigador.latitud!, 
                        registroInvestigador.longitud!, 
                        registroInvestigador.investigador);

                      if(registroMessage == null ){
                        showADialogCustom(context, onAccept: (context) => { finish(context)},
                        dialogType: DialogType.ACCEPT,
                        positiveText: 'Aceptar',
                        title: '¡Gracias por tu aporte!',
                        barrierDismissible: false,
                        );
                        registroInvestigador.isLoading = false;
                      } else {
                        showADialogCustom(context, onAccept: (context) {},
                        dialogType: DialogType.DELETE,
                        positiveText: 'Aceptar',
                        title: registroMessage,
                        barrierDismissible: false,
                        );
                        registroInvestigador.isLoading = false;
                      }
                     
                    } else {
                      NotificationsService.showSnackbar(erroMessage);
                      registroInvestigador.isLoading = false;
                    }
    
                  })
                  .paddingOnly(
                      left: context.width() * 0.1, right: context.width() * 0.1),
              30.height,
            ],
          ),
        ),
      ),
    );
  }
}
