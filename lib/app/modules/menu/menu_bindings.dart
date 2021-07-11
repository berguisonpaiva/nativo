import 'package:get/get.dart';
import 'package:nativo/app/modules/menu/menu_controller.dart';
import 'package:nativo/app/repositories/auth.dart';
import 'package:nativo/app/repositories/chamado_repository.dart';

class MenuBindings implements Bindings {
  @override
  void dependencies() {
      Get.put(Auth());
    Get.put(ChamadoRepository());
      Get.put(MenuController(Get.find()));
  }
}