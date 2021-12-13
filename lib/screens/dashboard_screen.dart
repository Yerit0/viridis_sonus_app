import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:viridis_sonus_app/utils/widgets/Colors.dart';
import 'screens.dart';

class DashboardScreen extends StatelessWidget {

  int _selectedIndex = 1;
  var _paginas = <Widget> [
    MenuRapidoScreen(),
    HomeScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _paginas.elementAt(_selectedIndex),
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
          currentIndex: _selectedIndex,
          onTap: (index) {
            //setState(() {
            //  _selectedIndex = index;
            //});
          },
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