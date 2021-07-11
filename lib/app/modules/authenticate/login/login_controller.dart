import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nativo/app/modules/splash/splash_page.dart';
import 'package:nativo/app/repositories/auth.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class LoginController extends GetxController with StateMixin {
  final Auth _auth;
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();


  GlobalKey<FormState> formKey = GlobalKey<FormState>(debugLabel: '_loginPage');
  LoginController(this._auth);

  @override
  Future<void> onInit() async {
    super.onInit();
   
  }

//deixar senha visivel
  final _obscureText = true.obs;
  get obscureText => _obscureText.value;
  void showHidePassword() => _obscureText.toggle();

  //login
  Future<void> login(String email, String password) async {
 
    try {
      await _auth.loginEmailPassword(email, password);

 var status = await OneSignal.shared.getDeviceState();
    var playerId = status!.userId;
    await FirebaseFirestore.instance
        .collection('dispositivos')
        .doc(playerId)
        .set({'id': playerId});
      Get.offNamed(SplashPage.ROUTE_PAGE);
    } on PlatformException catch (e) {
    
      print(e);
    } catch (e) {
    
      print(e);
    }
  }

 

}
