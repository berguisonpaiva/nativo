import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:validatorless/validatorless.dart';

import 'fechar_chamado_controller.dart';

class FecharChamadoPage extends GetView<FecharChamadoController> {
  static const String ROUTE_PAGE = '/fechar-chamado';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.carro.value),
      ),
      body: Form(
        key: controller.formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 5, left: 5),
                  child: Card(
                      elevation: 4,
                      child: ListTile(
                        title: Text(
                          controller.equipamento.value,
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(controller.dataHoraAbrimento.value,
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: 5,
                              ),
                              Text(controller.problema.value,
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      )),
                ),
                TextFormField(
                  initialValue: controller.solucao.value,
                  validator: Validatorless.required('Solução é obrigatorio!'),
                  onChanged: (value) => controller.solucao.value = value,
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
                    hintText: 'Qual foi a Solução ?',
                    labelText: 'Solução *',
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
                          controller.fechamentoChamado(
                             
                             controller.solucao.value);
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
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          )))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
