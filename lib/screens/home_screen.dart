import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:viridis_sonus_app/screens/screens.dart';
import 'package:viridis_sonus_app/services/services.dart';
import 'package:viridis_sonus_app/widgets/registro_widget.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final registrosService = Provider.of<RegistrosService>(context);
    final authService = Provider.of<AuthService>(context);
    final usuarioService = Provider.of<UsuarioService>(context);

    return Scaffold(
      body: Container(
        height: context.height(),
        width: context.width(),
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/wa_bg.jpg'), fit: BoxFit.cover),
        ),
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                50.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: boxDecorationWithRoundedCorners(
                        backgroundColor: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: RotatedBox(
                        quarterTurns: 2,
                        child: IconButton(
                          icon: Icon(Icons.logout_outlined, color: Colors.black),
                          onPressed: ()async{
                            await authService.logout();
                            await Provider.of<SonometroService>(context, listen: false).logout();
                            await Provider.of<UsuarioService>(context, listen: false).logout();
                            await Provider.of<RegistrosService>(context, listen: false).logout();
                            LoginScreen().launch(context, isNewTask: true);
                          },),
                      )
                        //onPressed: () => WAMyProfileScreen().launch(context),),
                    ),
                    usuarioService.infoUsuario != null
                    ? Text('Hola ${usuarioService.infoUsuario!.name}', style: primaryTextStyle(size: 20),)
                    : Text(''),
                    //GestureDetector(
                    //  onTap: (){
                    //          showDialog(
                    //            context: context, 
                    //            barrierDismissible: true,
                    //            builder: (_) =>AlertDialog(
                    //            actions: [
                    //              Container(
                    //                alignment: Alignment.center,
                    //                width: 80,
                    //                height: 80,
                    //                child: Center(
                    //                  child: Text('Calendario'),
                    //                ),
                    //              ),
                    //            ],
                    //          )
                    //        );
                    //      },
                    //  child: Container(
                    //    width: 200,
                    //    height: 40,
                    //    decoration: boxDecorationWithRoundedCorners(
                    //      backgroundColor: Colors.white,
                    //      borderRadius: BorderRadius.circular(12),
                    //      border: Border.all(color: Colors.grey),
                    //    ),
                    //    alignment: Alignment.center,
                    //    child: Stack(
                    //      alignment: AlignmentDirectional.topEnd,
                    //      children: [
                    //        Icon(Icons.date_range, 
                    //          color: Colors.black,
                    //        ),
                    //      ],
                    //    ),
                    //  ),
                    //),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: boxDecorationWithRoundedCorners(
                        backgroundColor: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey),
                      ),
                      alignment: Alignment.center,
                      child: Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          IconButton(
                            icon: Icon(Icons.language_outlined), 
                            color: Colors.black,
                            onPressed: () async { 
                              if (!await launch('https://viridussonus.cl/')) throw 'Could not launch url';}
                          ),
                        ],
                      ),
                    )
                  ],
                ).paddingOnly(left: 16, right: 16,bottom: 16),

                //Row(
                //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //  children: [
                //    Text('Transactions', style: boldTextStyle(size: 20)),
                //    Icon(Icons.play_arrow, color: Colors.grey),
                //  ],
                //).paddingOnly(left: 16, right: 16),
                16.height,
                
                registrosService.registros.length != 0
                ? Column(
                  children: [RegistroWidget(listRegistros: registrosService.registros, onNextPage: () => registrosService.getRegistros()),]
                )
                : Center(child: CupertinoActivityIndicator()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}