import 'package:flutter/material.dart';
import 'package:viridis_sonus_app/models/models.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class RegistroWidget extends StatefulWidget {
  final List<Registro> listRegistros;
  final Function onNextPage;
  const RegistroWidget({Key? key, required this.listRegistros, required this.onNextPage});


  @override
  State<RegistroWidget> createState() => _RegistroWidgetState();
}

class _RegistroWidgetState extends State<RegistroWidget> {

  final ScrollController scrollController = ScrollController();
  
  //get registroModel => this.registroModel;

  @override
  void initState() {
    scrollController.addListener(() async {
      if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
          widget.onNextPage();
          print(scrollController.position.maxScrollExtent);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final _urlMap = 'https://apis.viridussonus.cl/RegistrosSonido/MapsFull?tok=b3R0b3VsYnJpY2g=&claseSonometro=0&fechaDesde=&fechaHasta=&maxResultCount=10&skipCount=0&tipoUsuario=0&usuario=0&intensidad=0&IdRegistro=';
    final _color = Color(0xFF26C884);

    return Container(
      width: double.infinity,
      height: context.height(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.vertical,
              itemCount: widget.listRegistros.length,
              itemBuilder: ( _ , int index) => _RegistroItems(urlMap: _urlMap, registro: widget.listRegistros[index], color: _color),
              ),
          ),
        ],
      ),
    );
  }
}

class _RegistroItems extends StatelessWidget {
  const _RegistroItems({
    Key? key,
    required String urlMap,
    required this.registro,
    required Color color,
  }) : _urlMap = urlMap, _color = color, super(key: key);

  final String _urlMap;
  final Registro? registro;
  final Color _color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      margin: EdgeInsets.only(bottom: 16,left: 16,right: 16),
      decoration: boxDecorationRoundedWithShadow(16, backgroundColor: Colors.white),
      child: ListTile(
        onTap: () async {
          if (!await launch('$_urlMap${registro!.id}')) throw 'Could not launch url';
        },
        tileColor: Colors.red,
        enabled: true,
        contentPadding: EdgeInsets.zero,
        leading: Container(
          height: 50,
          width: 50,
          alignment: Alignment.center,
          decoration: boxDecorationWithRoundedCorners(
            boxShape: BoxShape.circle,
            backgroundColor: _color .withOpacity(0.1),
          ),
          child: Icon(Icons.location_on_outlined, color: Colors.green,)
        ),
        title: RichTextWidget(
          list: [
            TextSpan(
              text: 'Usuario: ',
              style: primaryTextStyle(size:13),
              children: [
                TextSpan(
                  text: '${registro!.creatorUser.userName}',
                  style: boldTextStyle(size: 15)
                )
              ],
            ),
            TextSpan(text: '\n'),
            TextSpan(
              text: 'Medido con: ',
              style: primaryTextStyle(size: 13),
              children: [
                TextSpan(
                  text: '${registro!.claseSonometro.descripcion}',
                  style: boldTextStyle(size: 15)
                  )
              ]
            )
          ],
          maxLines: 2,
        ),
        subtitle: Text('${registro!.fechaCreacion}', style: primaryTextStyle(color: Colors.black54, size: 14)),
        trailing: Icon(Icons.arrow_forward_ios_rounded, color: _color,)
      ),
    );
  }
}