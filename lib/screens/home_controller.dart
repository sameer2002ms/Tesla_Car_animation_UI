import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier{
  //we use home controller for logic part

  int selectedBottomTab = 0;
  void onBottonNavigationTabChange(int index) {
    selectedBottomTab = index;
    notifyListeners();
  }

  bool isRightDoorlock = true;
  bool isLeftDoorlock = true;
  bool isBonnetDoorlock = true;
  bool isBackDoorlock = true;

  void updateRightDoorLock() {
    isRightDoorlock = !isRightDoorlock;
    notifyListeners();
  }
    void updateLeftDoorLock(){
    isLeftDoorlock = !isLeftDoorlock;
    notifyListeners();
  }

  void updateBonnetDoorLock() {
    isBonnetDoorlock = !isBonnetDoorlock;
    notifyListeners();
  }

  void updateBackDoorLock() {
    isBackDoorlock = !isBackDoorlock;
    notifyListeners();
  }

  bool isCoolSelected = true;
  void updateCoolSelectedTab() {
    isCoolSelected = !isCoolSelected;
    notifyListeners();
  }

  bool isheatSelected = true;
  void updateheatSelectedTab() {
    isheatSelected = !isheatSelected;
    notifyListeners();
  }

}