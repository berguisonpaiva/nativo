import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:nativo/app/components/app_bottom_navigation.dart';
import 'package:validatorless/validatorless.dart';

import 'add_editar_chamado_controller.dart';

class AddEditarChamadoPage extends GetView<AddEditarChamadoController> {
  static const String ROUTE_PAGE = '/add-editar-chamado';
  static const int NAVIGATION_BAR_INDEX = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chamado'),
      ),
      bottomNavigationBar: AppBottomNavigation(NAVIGATION_BAR_INDEX),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(
            () => Form(
              key: controller.formKey,
              child: ListView(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.number,
                    initialValue: controller.carro.value,
                    validator: Validatorless.required('Carro é obrigatorio!'),
                    onChanged: (value) => controller.carro.value = value,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(
                        color: Get.theme.primaryColor,
                        fontSize: 18.0,
                      ),
                      icon: Icon(
                        Icons.bus_alert,
                        color: Get.theme.primaryColor,
                        size: 40,
                      ),
                      hintText: 'Qual o carro ?',
                      labelText: 'Carro *',
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    initialValue: controller.equipamento.value,
                    validator:
                        Validatorless.required('Equipamento é obrigatorio!'),
                    onChanged: (value) => controller.equipamento.value = value,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(
                        color: Get.theme.primaryColor,
                        fontSize: 18.0,
                      ),
                      icon: Icon(
                        Icons.manage_accounts_rounded,
                        color: Get.theme.primaryColor,
                        size: 40,
                      ),
                      hintText: 'Qual o equipamento ?',
                      labelText: 'Equipamento *',
                    ),
                  ),
                  TextFormField(
                    initialValue: controller.problema.value,
                    validator:
                        Validatorless.required('Problema é obrigatorio!'),
                    onChanged: (value) => controller.problema.value = value,
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(
                        color: Get.theme.primaryColor,
                        fontSize: 18.0,
                      ),
                      icon: Icon(
                        Icons.manage_accounts_rounded,
                        color: Get.theme.primaryColor,
                        size: 40,
                      ),
                      hintText: 'Qual o problema ?',
                      labelText: 'Problema *',
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                        onPressed: () {
                          if (controller.formKey.currentState!.validate()) {
                           
                            controller.createChamado(controller.carro.value,  controller.problema.value,controller.equipamento.value);
                          }
                        },
                        child: Text(
                          'Salvar',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Theme.of(context).primaryColor),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            )))),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
