import 'package:get/get.dart';
import 'package:nativo/app/modules/chamado/add-editar/add_editar_chamado_controller.dart';
import 'package:nativo/app/repositories/auth.dart';
import 'package:nativo/app/repositories/chamado_repository.dart';

class AddEditarChamadoBindings implements Bindings {
  @override
  void dependencies() {
          Get.put(Auth());
    Get.put(ChamadoRepository());
    Get.put(AddEditarChamadoController(Get.find(),Get.find()));
  }
}
