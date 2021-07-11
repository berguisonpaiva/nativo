import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'package:nativo/app/models/user_model.dart';
import 'package:nativo/app/modules/authenticate/login/login_page.dart';
import 'package:nativo/app/repositories/auth.dart';


class MenuController extends GetxController {


  final Auth _auth;



 UserModel? user;
  MenuController(
    
   this._auth,
 
  );


 @override
  void onInit() {
    super.onInit();
    findByUser();
  }

  
   Future<void> findByUser() async {
    try {
      final data = await _auth.findById();
      user = data;
    } catch (e) {
      print(e);
    }
  }
   Future<void> sair() async {
    try {
      FirebaseAuth.instance.signOut();
      1.seconds.delay();
      Get.offAllNamed(LoginPage.ROUTE_PAGE);
    } catch (e) {
      print(e);
    }
  }

}
