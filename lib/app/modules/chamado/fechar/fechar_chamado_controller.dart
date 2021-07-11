import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:nativo/app/models/chamado_model.dart';
import 'package:nativo/app/models/user_model.dart';

import 'package:nativo/app/repositories/auth.dart';
import 'package:nativo/app/repositories/chamado_repository.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class FecharChamadoController extends GetxController {
  final ChamadoRepository _chamadoRepository;
  final Auth _auth;
  final ChamadoModel? chamado;
  FecharChamadoController(
    this._auth,
    this._chamadoRepository,
    this.chamado,
  );
  UserModel? user;
  GlobalKey<FormState> formKey =
      GlobalKey<FormState>(debugLabel: '_fechaChamdo');

  final carro = Rx<String>('');
  final dataHoraAbrimento = Rx<String>('');
  final equipamento = Rx<String>('');
  final status = Rx<String>('');
  final tecnicoRecebido = Rx<String>('');
  final tecnicoFinalizado = Rx<String>('');
  final userAbriu = Rx<String>('');
  final problema = Rx<String>('');
  final solucao = Rx<String>('');
  final dataHoraFechamento = Rx<String>('');
List<String> _dispositivos = [];
  @override
  void onInit() {
    super.onInit();
    findByUser();
    dispositivosFindAll();
    carro(chamado?.carro);
    dataHoraAbrimento(chamado?.dataHoraAbertura);
    dataHoraFechamento(chamado?.dataHoraFechamento);
    equipamento(chamado?.equipamento);
    tecnicoRecebido(chamado?.tecnicoRecebido);
    userAbriu(chamado?.user);
    problema(chamado?.problema);
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

  Future<void> fechamentoChamado(
    String h,
  ) async {
    try {
      _chamadoRepository.fecharChamado(
          chamado!.id,
          chamado!.carro,
          chamado!.dataHoraAbertura,
          chamado!.problema,
          chamado!.user,
          chamado!.tecnicoRecebido,
          user!.nome,
          h,
          chamado!.equipamento,_dispositivos);

      Get.back(result: 'sucesso');
    } catch (e) {
      print(e);
    }
  }
}
