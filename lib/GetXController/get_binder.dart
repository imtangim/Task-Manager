import 'package:get/get.dart';
import 'package:task_manager/GetXController/auth_controller.dart';

class GetxDependencyBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
  }
}
