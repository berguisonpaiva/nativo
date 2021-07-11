import 'dart:io';

import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nativo/app/models/chamado_model.dart';
import 'package:nativo/app/models/user_model.dart';
import 'package:nativo/app/repositories/auth.dart';
import 'package:nativo/app/repositories/chamado_repository.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_extend/share_extend.dart';

class HomeController extends GetxController with StateMixin {
  final ChamadoRepository _chamadoRepository;
  final Auth _auth;

  HomeController(
    this._chamadoRepository,
    this._auth,
  );
  UserModel? user;
  final resolvidos = <ChamadoModel>[].obs;
  final chamadoPendentes = <ChamadoModel>[].obs;
  final chamadoEmandamento = <ChamadoModel>[].obs;
  List<String> _dispositivos = [];
  @override
  Future<void> onInit() async {
    super.onInit();
    findByUser();
    dispositivosFindAll();
    findAllpendente();
    findAllEmAndamento();
    findAllResolvidos();
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

  Future<void> findAllpendente() async {
    change([], status: RxStatus.loading());

    try {
      final data = await _chamadoRepository.findAllPendente();
      chamadoPendentes(data);
      change(chamadoPendentes, status: RxStatus.success());
    } catch (e) {
      change('Erro ao buscar loja', status: RxStatus.error());
    }
  }

  Future<void> findAllEmAndamento() async {
    change([], status: RxStatus.loading());

    try {
      final data = await _chamadoRepository.findAllEmAndamento();
      chamadoEmandamento(data);
      change(chamadoEmandamento, status: RxStatus.success());
    } catch (e) {
      change('Erro ao buscar loja', status: RxStatus.error());
    }
  }

  Future<void> findAllResolvidos() async {
    change([], status: RxStatus.loading());

    try {
      final data = await _chamadoRepository.findAllResolvidos();
      resolvidos(data);
      change(resolvidos, status: RxStatus.success());
    } catch (e) {
      change('Erro ao buscar loja', status: RxStatus.error());
    }
  }

  Future<void> showAlent(ChamadoModel chamado) async {
    try {
      await showDialog(
          context: Get.context!,
          builder: (context) {
            return AlertDialog(
              title: Text('!! Alerta !!'),
              content: Container(
                height: 200,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(chamado.user),
                      SizedBox(
                        height: 8,
                      ),
                      Text(chamado.carro),
                      SizedBox(
                        height: 8,
                      ),
                      Text(chamado.equipamento),
                      SizedBox(
                        height: 8,
                      ),
                      Text(chamado.problema),
                      SizedBox(
                        height: 15,
                      ),
                      Text('Deseja a ceitar o chamado ?'),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text('Não'),
                ),
                TextButton(
                  onPressed: () {
                    _chamadoRepository.updateChamado(chamado, user!.nome,_dispositivos);
                    Get.back();
                    onInit();
                  },
                  child: Text('sim'),
                )
              ],
            );
          });
    } catch (e) {
      print(e);
    }
  }

  Future<void> showAlentDelete(ChamadoModel chamado) async {
    try {
      await showDialog(
          context: Get.context!,
          builder: (context) {
            return AlertDialog(
              title: Text('!! Alerta !!'),
              content: Container(child: Text('Deseja excluir ?')),
              actions: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text('Não'),
                ),
                TextButton(
                  onPressed: () {
                    _chamadoRepository.deleteChamado(chamado.id);
                    Get.back();
                    onInit();
                  },
                  child: Text('sim'),
                )
              ],
            );
          });
    } catch (e) {
      print(e);
    }
  }

  Future<void> shared(ChamadoModel chamado) async {
    final pdf = pw.Document();

    final dataAtual = DateFormat('dd/MM/yyyy').format(DateTime.now());
    final horaAtual = DateFormat.Hms().format(DateTime.now());
    pdf.addPage(
      pw.MultiPage(
        maxPages: 200,
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(20),
        header: (pw.Context context) => pw.Container(
            color: PdfColor.fromHex('#3dba38'),
            width: double.infinity,
            child: pw.Column(children: [
              pw.Text('RELATORIO DE MANUTENÇÃO ',
                  style: pw.TextStyle(
                      fontSize: 25,
                      color: PdfColor.fromHex('#d2d4d2'),
                      fontWeight: pw.FontWeight.bold)),
            ])),
        build: (pw.Context context) {
          return <pw.Widget>[
            pw.Wrap(
              children: [
                pw.Container(
                    width: double.infinity,
                    child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.SizedBox(height: 15),
                          pw.Row(children: [
                            pw.Text('Data/Hora Abertura:',
                                style: pw.TextStyle(
                                    fontSize: 20,
                                    fontWeight: pw.FontWeight.bold)),
                            pw.SizedBox(width: 10),
                            pw.Text(chamado.dataHoraAbertura,
                                style: pw.TextStyle(
                                    fontSize: 20,
                                    fontWeight: pw.FontWeight.normal)),
                          ]),
                          pw.SizedBox(height: 10),
                          pw.Row(children: [
                            pw.Text('Usuario:',
                                style: pw.TextStyle(
                                    fontSize: 20,
                                    fontWeight: pw.FontWeight.bold)),
                            pw.SizedBox(width: 10),
                            pw.Text(chamado.user,
                                style: pw.TextStyle(
                                    fontSize: 20,
                                    fontWeight: pw.FontWeight.normal)),
                          ]),
                          pw.SizedBox(height: 10),
                          pw.Row(children: [
                            pw.Text('Carro:',
                                style: pw.TextStyle(
                                    fontSize: 20,
                                    fontWeight: pw.FontWeight.bold)),
                            pw.SizedBox(width: 10),
                            pw.Text(chamado.carro,
                                style: pw.TextStyle(
                                    fontSize: 20,
                                    fontWeight: pw.FontWeight.normal)),
                          ]),
                          pw.SizedBox(height: 10),
                          pw.Row(children: [
                            pw.Text('Equipamento:',
                                style: pw.TextStyle(
                                    fontSize: 20,
                                    fontWeight: pw.FontWeight.bold)),
                            pw.SizedBox(width: 10),
                            pw.Text(chamado.equipamento,
                                style: pw.TextStyle(
                                    fontSize: 20,
                                    fontWeight: pw.FontWeight.normal)),
                          ]),
                          pw.SizedBox(height: 10),
                          pw.Wrap(
                              crossAxisAlignment: pw.WrapCrossAlignment.start,
                              children: [
                                pw.Text('Problema:',
                                    style: pw.TextStyle(
                                        fontSize: 20,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.SizedBox(width: 10),
                                pw.Text(chamado.problema,
                                    style: pw.TextStyle(
                                        fontSize: 20,
                                        fontWeight: pw.FontWeight.normal)),
                              ]),
                          pw.SizedBox(height: 5),
                          pw.Row(children: [
                            pw.Text('Tecnico Recebido:',
                                style: pw.TextStyle(
                                    fontSize: 20,
                                    fontWeight: pw.FontWeight.bold)),
                            pw.SizedBox(width: 10),
                            pw.Text(chamado.tecnicoRecebido,
                                style: pw.TextStyle(
                                    fontSize: 20,
                                    fontWeight: pw.FontWeight.normal)),
                          ]),
                          pw.SizedBox(height: 10),
                          pw.Wrap(
                              crossAxisAlignment: pw.WrapCrossAlignment.start,
                              children: [
                                pw.Text('Solução:',
                                    style: pw.TextStyle(
                                        fontSize: 20,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.SizedBox(width: 10),
                                pw.Text(chamado.solucao,
                                    style: pw.TextStyle(
                                        fontSize: 20,
                                        fontWeight: pw.FontWeight.normal)),
                              ]),
                          pw.SizedBox(height: 5),
                          pw.Row(children: [
                            pw.Text('Tecnico Fechamento:',
                                style: pw.TextStyle(
                                    fontSize: 20,
                                    fontWeight: pw.FontWeight.bold)),
                            pw.SizedBox(width: 10),
                            pw.Text(chamado.tecnicoFinalizado,
                                style: pw.TextStyle(
                                    fontSize: 20,
                                    fontWeight: pw.FontWeight.normal)),
                          ]),
                          pw.SizedBox(height: 10),
                          pw.Row(children: [
                            pw.Text('Data/Hora Fechamento:',
                                style: pw.TextStyle(
                                    fontSize: 20,
                                    fontWeight: pw.FontWeight.bold)),
                            pw.SizedBox(width: 10),
                            pw.Text(chamado.dataHoraFechamento,
                                style: pw.TextStyle(
                                    fontSize: 20,
                                    fontWeight: pw.FontWeight.normal)),
                          ]),
                        ]))
              ],
            )
          ];
        },
        footer: (pw.Context context) => pw.Align(
            alignment: pw.Alignment.bottomRight,
            child: pw.Text('${dataAtual.toString()}--${horaAtual.toString()}')),
      ),
    );

    final String dir = (await getApplicationDocumentsDirectory()).path;

    final String path = '$dir/relatorio-carro-${chamado.carro}.pdf';
    final File file = File(path);

    file.writeAsBytesSync(await pdf.save());
    showAlentl(file, path);
  }

  Future<void> showAlentl(File file, String path) async {
    PDFDocument doc = await PDFDocument.fromFile(file);
    try {
      await showBarModalBottomSheet(
          context: Get.context!,
          builder: (context) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Relatório'),
                actions: [
                  IconButton(
                      icon: Icon(
                        Icons.share,
                        color: Colors.white,
                      ),
                      iconSize: 30,
                      onPressed: () {
                        ShareExtend.share(path, "file",
                            sharePanelTitle: "Enviar PDF",
                            subject: "Relatorio de Manutenção -pdf");
                      }),
                ],
              ),
              body: PDFViewer(document: doc),
            );
          });
    } catch (e) {
      print(e);
    }
  }
}
