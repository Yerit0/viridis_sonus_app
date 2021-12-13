import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:viridis_sonus_app/providers/providers.dart';
import 'package:viridis_sonus_app/utils/widgets/Colors.dart';
import 'screens.dart';

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
    return Scaffold(
      body: tabPage.paginas.elementAt(tabPage.selectedIndex),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.all(6.0),
        child: FloatingActionButton(
          backgroundColor: PrimaryColor,
          child: Icon(Icons.mic, color: Colors.white),
          onPressed: () {
            //VSGrabacionScreen().launch(context);
          },
        ),
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