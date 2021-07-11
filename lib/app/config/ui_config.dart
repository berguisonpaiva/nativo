import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:nativo/app/modules/authenticate/login/login_bindings.dart';
import 'package:nativo/app/modules/authenticate/login/login_page.dart';
import 'package:nativo/app/modules/authenticate/register/register_bindings.dart';
import 'package:nativo/app/modules/authenticate/register/register_page.dart';
import 'package:nativo/app/modules/chamado/add-editar/add_editar_chamado_bindings.dart';

import 'package:nativo/app/modules/chamado/add-editar/add_editar_chamado_page.dart';
import 'package:nativo/app/modules/chamado/fechar/fechar_chamado_bindings.dart';
import 'package:nativo/app/modules/chamado/fechar/fechar_chamado_page.dart';
import 'package:nativo/app/modules/home/home_bindings.dart';
import 'package:nativo/app/modules/home/home_page.dart';
import 'package:nativo/app/modules/menu/menu_bindings.dart';
import 'package:nativo/app/modules/menu/menu_page.dart';
import 'package:nativo/app/modules/splash/splash_bindings.dart';
import 'package:nativo/app/modules/splash/splash_page.dart';

class UiConfig {
  UiConfig._();

  static final appTheme = ThemeData(
      primaryColor: Color(0xFF074607),
      primaryColorDark: Color(0xFF074607),
      primaryColorLight: Color(0xFFFF5030),
      accentColor: Color(0xFF484848));

  static final routes = <GetPage>[
    GetPage(
      name: SplashPage.ROUTE_PAGE,
      page: () => SplashPage(),
      binding: SplashBindings(),
    ),
    GetPage(
      name: HomePage.ROUTE_PAGE,
      page: () => HomePage(),
      binding: HomeBindings(),
    ),
    GetPage(
      name: AddEditarChamadoPage.ROUTE_PAGE,
      page: () => AddEditarChamadoPage(),
      binding: AddEditarChamadoBindings(),
    ),
      GetPage(
      name: MenuPage.ROUTE_PAGE,
      page: () => MenuPage(),
      binding: MenuBindings(),
    ),
    GetPage(
      name: FecharChamadoPage.ROUTE_PAGE,
      page: () => FecharChamadoPage(),
      binding: FecharChamadoBindings(),
    ),
    GetPage(
      name: LoginPage.ROUTE_PAGE,
      page: () => LoginPage(),
      binding: LoginBindings(),
    ),
    GetPage(
      name: RegisterPage.ROUTE_PAGE,
      page: () => RegisterPage(),
      binding: RegisterBindings(),
    ),
  ];
}
