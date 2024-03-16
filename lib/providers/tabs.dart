import 'package:binario_m/utils/global.dart';
import 'package:flutter/cupertino.dart';

class TabsProvider with ChangeNotifier {
  Tabs _currentTab = Tabs.route;
  Tabs get currentTab => _currentTab;
  set currentTab(Tabs tab) {
    _currentTab = tab;
    notifyListeners();
  }

  void changeTab(Tabs tab) {
    _currentTab = tab;
    notifyListeners();
  }
}
