import 'package:get/get.dart';
import 'package:task_manager/GetXController/login_controller.dart';
import 'package:task_manager/GetXController/profile_update_controller.dart';
import 'package:task_manager/GetXController/share_preference_controller.dart';
import 'package:task_manager/GetXController/signup_controller.dart';
import 'package:task_manager/GetXController/swith_controller.dart';
import 'package:task_manager/GetXController/taskStatus_controller.dart';
import 'package:task_manager/GetXController/task_controller.dart';

class GetxDependencyBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(SignupController());
    Get.put(LoginController());
    Get.put(SharedPreferenceController());
    Get.put(TaskController());
    Get.put(SwitchController());
    Get.put(ProfileUpdateController());
    Get.put(TaskStatusController());
  }
}
