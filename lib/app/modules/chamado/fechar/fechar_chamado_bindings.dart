import 'package:get/get.dart';
import 'package:nativo/app/repositories/auth.dart';
import 'package:nativo/app/repositories/chamado_repository.dart';

import 'fechar_chamado_controller.dart';

class FecharChamadoBindings implements Bindings {
  @override
  void dependencies() {
            Get.put(Auth());
    Get.put(ChamadoRepository());
    Get.put(FecharChamadoController(Get.find(),Get.find(), Get.arguments));
  }
}
