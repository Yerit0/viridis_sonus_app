import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:viridis_sonus_app/providers/registro_investigador_provider.dart';
import 'package:viridis_sonus_app/services/sonometro_services.dart';
import 'package:viridis_sonus_app/utils/widgets/Colors.dart';
import 'package:viridis_sonus_app/utils/widgets/Widgets.dart';

class RegistroInvestigadorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

    final registroInvestigadorProvider = Provider.of<RegistroInvestigadorProvider>(context);
    final sonometroService = Provider.of<SonometroService>(context);

    
    return Container(
      child: Form(
        key: registroInvestigadorProvider.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            50.height,
            Text("Mínima", style: boldTextStyle(size: 14)),
            8.height,
            AppTextField(
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
                  registroInvestigadorProvider.minima = double.parse(value);
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
                  registroInvestigadorProvider.media = double.parse(value);
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
                  registroInvestigadorProvider.maxima = double.parse(value);
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
                return new DropdownMenuItem<String>(
                  value: sonometroItems.id.toString(),
                  child: Text(sonometroItems.descripcion, style: secondaryTextStyle()),
                );
              }).toList(),
              onChanged: (String? value) {
                if(value != null){
                  registroInvestigadorProvider.claseSonometroId = int.parse(value);
                }
              },
              validator: (value) {
                return value != null
                ? null
                : 'Selecciona un sonómetro';
              },
            ),
            30.height,
            AppButton(
              text: "Registrar Medición",
              color: PrimaryColor,
              textColor: Colors.white,
              shapeBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)),
                width: context.width(),
                onTap: registroInvestigadorProvider.isLoading ? null :() async {
                  FocusScope.of(context).unfocus();
                      //final authService = Provider.of<AuthService>(context, listen: false);

                      if(!registroInvestigadorProvider.isValidForm()) return;

                    })
                .paddingOnly(
                    left: context.width() * 0.1, right: context.width() * 0.1),
            30.height,
          ],
        ),
      ),
    );
  }
}
