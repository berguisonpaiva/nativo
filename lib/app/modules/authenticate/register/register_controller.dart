import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:nativo/app/repositories/auth.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class RegisterController extends GetxController with StateMixin {
  final Auth _auth;
  final nomeEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final confirmepasswordEditingController = TextEditingController();
  GlobalKey<FormState> formKey =
      GlobalKey<FormState>(debugLabel: '_registerPage');
  RegisterController(this._auth);

  @override
  void onInit() {
    super.onInit();
  }

  //deixar senha visivel
  final _obscureText = true.obs;
  get obscureText => _obscureText.value;
  void showHidePassword() => _obscureText.toggle();

  //deixar senha visivel
  final _obscureTextConfime = true.obs;
  get obscureTextConfime => _obscureTextConfime.value;
  void showHidePasswordConfime() => _obscureTextConfime.toggle();

  Future<void> createUser(String nome, String email, String password) async {
  
    try {
      await _auth.createUse(nome, email, password);

      await 1.seconds.delay();
      Fluttertoast.showToast(
          msg: 'User criado com sucesso',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
           var status = await OneSignal.shared.getDeviceState();
    var playerId = status!.userId;
    await FirebaseFirestore.instance
        .collection('dispositivos')
        .doc(playerId)
        .set({'id': playerId});
           
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(
            msg: "A senha fornecida é muito fraca.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
            msg: "A conta já existe para esse e-mail.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (e) {
     
      Fluttertoast.showToast(
          msg: '$e',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
