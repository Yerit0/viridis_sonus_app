import 'package:flutter/material.dart';
import 'package:viridis_sonus_app/screens/screens.dart';

class TabPageProvider extends ChangeNotifier{

  int _selectedIndex = 1;
  var _paginas = <Widget>[
    QuickMenuScreen(),
    HomeScreen()
  ];

  int get selectedIndex => _selectedIndex;
  set selectedIndex(int value) {
    _selectedIndex = value;
    notifyListeners();
  }

  get paginas => _paginas;

  }

