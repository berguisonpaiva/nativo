import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ChamadoModel {
  DocumentReference id;
  String carro;
  String dataHoraAbertura;
  String dataHoraFechamento;
  String problema;
  String solucao;
  String equipamento;
  String tecnicoFinalizado;
  String tecnicoRecebido;
  String status;
  String user;
  ChamadoModel({
    required this.id,
    required this.carro,
    required this.dataHoraAbertura,
    required this.dataHoraFechamento,
    required this.problema,
    required this.solucao,
    required this.equipamento,
    required this.tecnicoFinalizado,
    required this.tecnicoRecebido,
    required this.status,
    required this.user,
  });

  factory ChamadoModel.fronDocument(DocumentSnapshot doc) {
    return ChamadoModel(
      id: doc.reference,
      carro: doc['carro'],
      dataHoraAbertura: doc['dataHoraAbertura'],
      dataHoraFechamento: doc['dataHoraFechamento'],
      problema: doc['problema'],
      solucao: doc['solucao'],
      equipamento: doc['equipamento'],
      tecnicoFinalizado: doc['tecnicoFinalizado'],
      user: doc['user'],
      tecnicoRecebido: doc['tecnicoRecebido'],
      status: doc['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'carro': carro,
      'dataHoraAbertura': dataHoraAbertura,
      'dataHoraFechamento': dataHoraFechamento,
      'problema': problema,
      'solucao': solucao,
      'equipamento': equipamento,
      'tecnicoFinalizado': tecnicoFinalizado,
      'tecnicoRecebido': tecnicoRecebido,
      'status': status,
      'user': user,
    };
  }

  factory ChamadoModel.fromMap(Map<String, dynamic> map) {
    return ChamadoModel(
      id: map['DocumentReference'],
      carro: map['carro'],
      dataHoraAbertura: map['dataHoraAbertura'],
      dataHoraFechamento: map['dataHoraFechamento'],
      problema: map['problema'],
      solucao: map['solucao'],
      equipamento: map['equipamento'],
      tecnicoFinalizado: map['tecnicoFinalizado'],
      tecnicoRecebido: map['tecnicoRecebido'],
      status: map['status'],
      user: map['user'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ChamadoModel.fromJson(String source) => ChamadoModel.fromMap(json.decode(source));
}
