import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:nativo/app/models/user_model.dart';

import 'package:nativo/app/modules/home/home_page.dart';
import 'package:nativo/app/repositories/auth.dart';

import 'package:nativo/app/repositories/chamado_repository.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class AddEditarChamadoController extends GetxController {
  final ChamadoRepository _chamadoRepository;
  final Auth _auth;
  AddEditarChamadoController(
    this._chamadoRepository,
    this._auth,
  );
  UserModel? user;
  GlobalKey<FormState> formKey =
      GlobalKey<FormState>(debugLabel: '_chamadoPage');

  final carro = Rx<String>('');
  final dataHoraAbrimento = Rx<String>('');
  final equipamento = Rx<String>('');
  final problema = Rx<String>('');
  List<String> _dispositivos = [];
  @override
  void onInit() {
    super.onInit();
    findByUser();
    dispositivosFindAll();
  }

  Future<void> dispositivosFindAll() async {
    var status = await OneSignal.shared.getDeviceState();
    var playerId = status!.userId;
    print('id: $playerId');
    try {
      final eventoData = await _chamadoRepository.dispositivo();

      eventoData!.forEach((element) {
        _dispositivos.add(element.id!);
        _dispositivos.remove(playerId);
      });
      print(_dispositivos);
    } catch (e) {
      print(e);
    }
  }

  Future<void> findByUser() async {
    try {
      final data = await _auth.findById();
      user = data;
    } catch (e) {
      print(e);
    }
  }

  Future<void> createChamado(
    String carro,
    String problema,
    String equipamento,
  ) async {
    try {
      _chamadoRepository.createChamado(
          carro, problema, user!.nome, equipamento, _dispositivos);

      Get.offAllNamed(HomePage.ROUTE_PAGE);
    } catch (e) {
      print(e);
    }
  }
}
