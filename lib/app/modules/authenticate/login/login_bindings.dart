import 'package:get/get.dart';
import 'package:nativo/app/repositories/auth.dart';

import 'login_controller.dart';

class LoginBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(Auth());
    Get.put(LoginController(Get.find()));
  }
}
