import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:nativo/app/models/user_logged.dart';
import 'package:nativo/app/modules/authenticate/login/login_page.dart';
import 'package:nativo/app/modules/home/home_page.dart';

class SplashController extends GetxController {
  var _logged = UserLogged.empty.obs;
  UserLogged get logged => _logged.value;
  @override
  void onInit() {
    super.onInit();
    ever<UserLogged>(_logged, _checkIsLogged);
    checkLogin();
  }

  Future<void> checkLogin() async {
    await 2.seconds.delay();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        _logged(UserLogged.unauthenticate);
      } else {
        _logged(UserLogged.authenticate);
      }
    });
  }

  void _checkIsLogged(UserLogged userLogged) {
    switch (userLogged) {
      case UserLogged.authenticate:
        Get.offNamed(HomePage.ROUTE_PAGE);
        break;
      case UserLogged.unauthenticate:
        Get.offNamed(LoginPage.ROUTE_PAGE);
        break;
      case UserLogged.empty:
        break;
      default:
    }
  }
}
