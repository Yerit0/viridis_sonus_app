import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:viridis_sonus_app/utils/widgets/Colors.dart';
import 'package:url_launcher/url_launcher.dart';

class QuickMenuScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('Menu Rápido', style: boldTextStyle(color: Colors.black, size: 20)),
          centerTitle: true,
          automaticallyImplyLeading: false,
          elevation: 0.0,
          brightness: Brightness.dark,
        ),
        body: 
        Center(
          child: Container(
            width: context.width(),
            height: context.height(),
            padding: EdgeInsets.only(top: 60),
            decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/wa_bg.jpg'), fit: BoxFit.cover),
          ),
          child: Container(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AppButton(
                    text: "BLOGS",
                    color: PrimaryColor,
                    textColor: Colors.white,
                    shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    width: context.width(),
                    onTap: () async { 
                      if (!await launch('https://viridussonus.cl/blog/')) throw 'Could not launch url';
                    }).paddingOnly(left: context.width() * 0.05, right: context.width() * 0.05),
                  SizedBox(height: 20,),
                  AppButton(
                    text: "TIPS",
                    color: PrimaryColor,
                    textColor: Colors.white,
                    shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    width: context.width(),
                    onTap: () async {
                      if (!await launch('https://viridussonus.cl/tips/')) throw 'Could not launch url';
                    }).paddingOnly(left: context.width() * 0.05, right: context.width() * 0.05),
                  SizedBox(height: 20,),
                  AppButton(
                    text: "Políticas de Privacidad",
                    color: PrimaryColor,
                    textColor: Colors.white,
                    shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    width: context.width(),
                    onTap: ()  {
                      Navigator.pushNamed(context, 'policy');
                    },).paddingOnly(left: context.width() * 0.05, right: context.width() * 0.05),
                  SizedBox(height: 20,),
                  
                 
                ],
              )),
          ),
        ),
        ),
        //Container(
        //  height: context.height(),
        //  width: context.width(),
        //  padding: EdgeInsets.only(top: 60),
        //  decoration: BoxDecoration(image: DecorationImage(image: AssetImage('images/walletApp/wa_bg.jpg'), fit: BoxFit.cover)),
        //  //child: SingleChildScrollView(
        //    child:  Column(
        //        crossAxisAlignment: CrossAxisAlignment.start,
        //        children: [
        //          Text('pagina de prueba'),
//
        //        ],
        //    ),
        //  //),
        //),

    );
  }
  }