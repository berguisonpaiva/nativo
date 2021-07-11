import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nativo/app/models/user_model.dart';


class Auth {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> loginEmailPassword(String email, String password) async {

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(
          
            msg: "Usuario não existe!",
            toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      }
    } on PlatformException catch (e) {
      print(e);
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<void> createUse(
    String nome,
    String email,
    String password,
  ) async {
     
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await db
          .collection('user')
          .doc(email)
          .set({'nome': nome, 'email': email, 'role': 'User'});

         
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('A senha fornecida é muito fraca.');
        Fluttertoast.showToast(
            msg: "A senha fornecida é muito fraca.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (e.code == 'email-already-in-use') {
        print('A conta já existe para esse e-mail.');
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
      print('o erro é : -- $e--');
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<UserModel?> findById() async {
    try {
      print(auth.currentUser?.email);
      final response =
          await db.collection('user').doc(auth.currentUser?.email).get();
      var teste = UserModel.fronDocument(response);
      print(teste.nome);
      return teste;
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Erro ao buscar user.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
