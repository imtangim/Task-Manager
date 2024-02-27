import 'package:get/get.dart';

class SwitchController extends GetxController {
  bool switchvalue=true;
  bool notificationSwitchvalue=true;

  void switchShifter(){
    switchvalue = !switchvalue;
    update();
  }
  void notificationSwitchShifter(){
    notificationSwitchvalue = !notificationSwitchvalue;
    update();
  }
}