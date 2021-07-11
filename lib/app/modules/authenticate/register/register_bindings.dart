import 'package:get/get.dart';
import 'package:nativo/app/modules/authenticate/register/register_controller.dart';
import 'package:nativo/app/repositories/auth.dart';

class RegisterBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(Auth());
    Get.put(RegisterController(Get.find()));
  }
}
