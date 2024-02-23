import 'package:get/get.dart';
import 'package:task_manager/GetXController/login_controller.dart';
import 'package:task_manager/GetXController/signup_controller.dart';


class GetxDependencyBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(SignupController());
    Get.put(LoginController());
  }
}
