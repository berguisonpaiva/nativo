import 'package:get/get.dart';
import 'package:nativo/app/repositories/auth.dart';
import 'package:nativo/app/repositories/chamado_repository.dart';

import 'home_controller.dart';

class HomeBindings implements Bindings {
  @override
  void dependencies() {
      Get.put(Auth());
    Get.put(ChamadoRepository());
    Get.put(HomeController(Get.find(),Get.find()));
  }
}
