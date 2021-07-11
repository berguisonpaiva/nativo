import 'package:cloud_firestore/cloud_firestore.dart';

class DispositivelModel {
  String? id;
  DispositivelModel({
    this.id,
  });
   factory DispositivelModel.fromDocument(DocumentSnapshot doc) {
    return DispositivelModel(
   
      id: doc['id'],
    );
  }
}
