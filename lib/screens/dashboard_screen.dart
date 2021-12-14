import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:viridis_sonus_app/providers/providers.dart';
import 'package:viridis_sonus_app/services/services.dart';
import 'package:viridis_sonus_app/utils/widgets/Colors.dart';


class DashboardScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: ( _ ) => TabPageProvider(),
      child: _BuildDashboard(),
    );
  }
}

class _BuildDashboard extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final tabPage = Provider.of<TabPageProvider>(context);
    final sonometroServices = Provider.of<SonometroService>(context);
    final usuarioService = Provider.of<UsuarioService>(context);

    return Scaffold(
      body: tabPage.paginas.elementAt(tabPage.selectedIndex),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.all(6.0),
        child: usuarioService.infoUsuario == null
        ? FloatingActionButton(
          backgroundColor: PrimaryColor,
          child: CupertinoActivityIndicator(),
          onPressed: () {
          },
        )
        : usuarioService.infoUsuario!.roles.contains('Investigador')
        ? SpeedDial(
          icon: Icons.add,
          activeIcon: Icons.close,
          overlayColor: Colors.black,
          overlayOpacity: 0.2,
          backgroundColor: PrimaryColor,
          children: [
            SpeedDialChild(
              child: Icon(Icons.phone_android_outlined), 
              backgroundColor: PrimaryColor,
              onTap: () => Navigator.pushNamed(context, 'celular')),
            SpeedDialChild(
              child: Icon(Icons.mic_external_on_outlined), 
              backgroundColor: PrimaryColor,
              onTap: () => Navigator.pushNamed(context, 'investigador'))
          ],
        )
        : FloatingActionButton(
          backgroundColor: PrimaryColor,
          child: Icon(Icons.add),
          onPressed: () => Navigator.pushNamed(context, 'celular')
        )
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        clipBehavior: Clip.antiAlias,
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: tabPage.selectedIndex,
          onTap: (index) {
            tabPage.selectedIndex = index;
            } ,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: PrimaryColor,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'menurapido'),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          ],
        ),
      ),
    );
  }
}