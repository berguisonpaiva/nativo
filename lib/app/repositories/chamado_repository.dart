import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:nativo/app/models/chamado_model.dart';
import 'package:nativo/app/models/dispositivel.model.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class ChamadoRepository {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createChamado(String carro, String problema, String user,
      String equipamento, List<String> dispositivo) async {
    for (var tes in dispositivo) {
      await OneSignal.shared.postNotification(OSCreateNotification(
          playerIds: [tes],
          content:
              'Carro: $carro -- Equipamento: $equipamento -- Problema: $problema-- Responsavel: $user ',
          heading: 'Chamado Aberto'));
    }
    try {
      await _db.collection('Chamados-pendente').add({
        'carro': carro,
        'dataHoraAbertura':
            DateFormat('dd/MM/yyyy -- H:m:s ').format(DateTime.now()),
        'dataHoraFechamento': '',
        'problema': problema,
        'user': user,
        'tecnicoRecebido': '',
        'tecnicoFinalizado': '',
        'solucao': '',
        'equipamento': equipamento,
        'status': 'pendente'
      });
    } on FirebaseAuthException catch (e) {
      print(e);
    } on PlatformException catch (e) {
      print(e);
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<List<DispositivelModel>?> dispositivo() async {
    try {
      final response = await _db.collection('dispositivos').get();

      return response.docs.map((e) {
        return DispositivelModel.fromDocument(e);
      }).toList();
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateChamado(
      ChamadoModel chamado, String user, List<String> dispositivo) async {
    for (var tes in dispositivo) {
      await OneSignal.shared.postNotification(OSCreateNotification(
          playerIds: [tes],
          content:
              'Tecnico: $user Carro: ${chamado.carro} -- Equipamento: ${chamado.equipamento} -- Problema: ${chamado.problema}-- Responsavel  ${chamado.user} ',
          heading: 'Chamado em Andamento'));
    }
    try {
      await _db.collection('Chamados-pendente').doc(chamado.id.id).delete();
      await _db.collection('Chamados-em-andamento').doc(chamado.id.id).set({
        'carro': chamado.carro,
        'dataHoraAbertura': chamado.dataHoraAbertura,
        'dataHoraFechamento': chamado.dataHoraFechamento,
        'problema': chamado.problema,
        'user': chamado.user,
        'tecnicoRecebido': user,
        'tecnicoFinalizado': chamado.tecnicoFinalizado,
        'solucao': chamado.solucao,
        'equipamento': chamado.equipamento,
        'status': 'em andamento',
      });
    } on FirebaseAuthException catch (e) {
      print(e);
    } on PlatformException catch (e) {
      print(e);
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<void> fecharChamado(
      DocumentReference id,
      String a,
      String b,
      String d,
      String e,
      String f,
      String g,
      String h,
      String i,
      List<String> dispositivo) async {
    for (var tes in dispositivo) {
      await OneSignal.shared.postNotification(OSCreateNotification(
          playerIds: [tes],
          content:
              'Tecnico: $g Carro: $a -- Equipameto: $i -- Problema: $d--Responsavel  $e ',
          heading: 'Chamado Resolvido'));
    }
    try {
      await _db.collection('Chamados-em-andamento').doc(id.id).delete();
      await _db.collection('Chamados--resolvidos').doc(id.id).set({
        'carro': a,
        'dataHoraAbertura': b,
        'dataHoraFechamento':
            DateFormat('dd/MM/yyyy -- H:m:s ').format(DateTime.now()),
        'problema': d,
        'user': e,
        'tecnicoRecebido': f,
        'tecnicoFinalizado': g,
        'solucao': h,
        'equipamento': i,
        'status': 'ok',
      });
    } on FirebaseAuthException catch (e) {
      print(e);
    } on PlatformException catch (e) {
      print(e);
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<List<ChamadoModel>?> findAllResolvidos() async {
    try {
      final response = await _db
          .collection('Chamados--resolvidos')
          .orderBy('dataHoraAbertura',descending: false)
          .get();
      return response.docs.map<ChamadoModel>((e) {
        return ChamadoModel.fronDocument(e);
      }).toList();
    } on FirebaseAuthException catch (e) {
      print(e);
    } on PlatformException catch (e) {
      print(e);
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<List<ChamadoModel>?> findAllPendente() async {
    try {
      final response = await _db
          .collection('Chamados-pendente')
          .orderBy('dataHoraAbertura',descending: false)
          .get();
      return response.docs.map<ChamadoModel>((e) {
        return ChamadoModel.fronDocument(e);
      }).toList();
    } on FirebaseAuthException catch (e) {
      print(e);
    } on PlatformException catch (e) {
      print(e);
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<List<ChamadoModel>?> findAllEmAndamento() async {
    try {
      final response = await _db
          .collection('Chamados-em-andamento')
          .orderBy('dataHoraAbertura',descending: false)
          .get();
      return response.docs.map<ChamadoModel>((e) {
        return ChamadoModel.fronDocument(e);
      }).toList();
    } on FirebaseAuthException catch (e) {
      print(e);
    } on PlatformException catch (e) {
      print(e);
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<void> deleteChamado(DocumentReference reference) async {
    try {
      await _db.collection('Chamados-pendente').doc(reference.id).delete();
      return null;
    } on FirebaseAuthException catch (e) {
      print(e);
    } on PlatformException catch (e) {
      print(e);
    } on Exception catch (e) {
      print(e);
    }
  }
}
