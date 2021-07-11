import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  DocumentReference id;
  String nome;
  String email;
  String role;
  UserModel({
    required this.id,
    required this.nome,
    required this.email,
    required this.role,
  });

  UserModel copyWith({
    DocumentReference? id,
    String? nome,
    String? email,
    String? password,
  }) {
    return UserModel(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      email: email ?? this.email,
      role: password ?? this.role,
    );
  }

  factory UserModel.fronDocument(DocumentSnapshot doc) {
    return UserModel(
      id: doc.reference,
      nome: doc['nome'],
      email: doc['email'],
      role: doc['role'],
    );
  }
}
