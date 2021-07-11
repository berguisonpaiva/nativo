import 'package:flutter/material.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:get/get.dart';
import 'package:nativo/app/components/app_bottom_navigation.dart';
import 'package:nativo/app/models/chamado_model.dart';
import 'package:nativo/app/modules/chamado/fechar/fechar_chamado_page.dart';

import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  static const String ROUTE_PAGE = '/home';
  static const int NAVIGATION_BAR_INDEX = 0;
  final pagecontrole = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Página Inicial'),
      ),
      bottomNavigationBar: AppBottomNavigation(NAVIGATION_BAR_INDEX),
      body: Container(
        color: Get.theme.primaryColor,
        child: ContainedTabBarView(
          tabs: [
            Text('Pendentes'),
            Text('Em Andamento'),
            Text('Resolvidos'),
          ],
          views: [
            Container(
              color: Colors.white,
              child: controller.obx((state) => _pendentes(state),
                  onError: (state) => Center(
                        child: Text('Erro ao buscar Chamado'),
                      )),
            ),
            Container(
              color: Colors.white,
              child: controller.obx((state) => _emAndamento(state),
                  onError: (state) => Center(
                        child: Text('Erro ao buscar Chamado'),
                      )),
            ),
            Container(
              color: Colors.white,
              child: controller.obx((state) => _resolvidos(state),
                  onError: (state) => Center(
                        child: Text('Erro ao buscar Chamado'),
                      )),
            ),
          ],
        ),
      ),
    );
  }

  Visibility _pendentes(List<ChamadoModel> state) {
    return Visibility(
      visible: controller.chamadoPendentes.length > 0,
      replacement: RefreshIndicator(
        onRefresh: controller.onInit,
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(16.0),
          child: Text('Nenhum chamado pendente'),
        ),
      ),
      child: Obx(
        () => RefreshIndicator(
          onRefresh: controller.onInit,
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: controller.chamadoPendentes.length,
                itemBuilder: (_, index) {
                  var model = controller.chamadoPendentes[index];

                  return Padding(
                    padding: const EdgeInsets.only(right: 5, left: 5),
                    child: Card(
                        elevation: 1,
                        child: ListTile(
                          onTap: () {
                            if (controller.user!.role == 'tecnico' ||
                                controller.user!.role == 'adm') {
                              controller.showAlent(model);
                            }
                          },
                          trailing: IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              if (model.user == controller.user!.nome) {
                                controller.showAlentDelete(model);
                              }
                            },
                          ),
                          leading: Icon(
                            Icons.directions_bus,
                            color: Colors.red,
                            size: 50.0,
                          ),
                          title: Text(
                            model.carro,
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Row(
                            children: [
                              Text(model.dataHoraAbertura),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          ),
                        )),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Visibility _emAndamento(List<ChamadoModel> state) {
    return Visibility(
      visible: controller.chamadoEmandamento.length > 0,
      replacement: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16.0),
        child: Text('Nenhum chamado em andamento'),
      ),
      child: Obx(
        () => RefreshIndicator(
          onRefresh: controller.onInit,
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: controller.chamadoEmandamento.length,
                itemBuilder: (_, index) {
                  var model = controller.chamadoEmandamento[index];

                  return Padding(
                    padding: const EdgeInsets.only(right: 5, left: 5),
                    child: Card(
                        elevation: 4,
                        child: ListTile(
                          onTap: () async {
                            if (controller.user!.role == 'tecnico' ||
                                controller.user!.role == 'adm') {
                              var status = await Get.toNamed(
                                  FecharChamadoPage.ROUTE_PAGE,
                                  arguments: model);
                              if (status == 'sucesso') {
                                controller.onInit();
                              }
                            }
                          },
                          leading: Icon(
                            Icons.directions_bus,
                            color: Colors.yellow[800],
                            size: 50.0,
                          ),
                          title: Text(
                            model.carro,
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Row(
                            children: [
                              Text(model.dataHoraAbertura),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          ),
                        )),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Visibility _resolvidos(List<ChamadoModel> state) {
    return Visibility(
      visible: controller.resolvidos.length > 0,
      replacement: Container(
          color: Colors.white,
          padding: EdgeInsets.all(16.0),
          child: Text('Nenhum chamado resolvido'),
        
      ),
      child: Obx(
        () => RefreshIndicator(
          onRefresh: controller.onInit,
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: controller.resolvidos.length,
                itemBuilder: (_, index) {
                  var model = controller.resolvidos[index];

                  return Padding(
                    padding: const EdgeInsets.only(right: 5, left: 5),
                    child: Card(
                        elevation: 1,
                        child: ListTile(
                          onTap: () {
                            controller.shared(model);
                          },
                          leading: Icon(
                            Icons.directions_bus,
                            color: Colors.green,
                            size: 50.0,
                          ),
                          title: Text(
                            model.carro,
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Row(
                            children: [
                              Text(model.dataHoraAbertura),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          ),
                        )),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
