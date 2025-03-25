import 'package:flutter/widgets.dart';


class Homeviewmodel extends ChangeNotifier {

int _selectedIndex=0;

int get selectedIndex => _selectedIndex;

void changePage(int selectedIndex){
    _selectedIndex=selectedIndex;
    notifyListeners();
}








}
