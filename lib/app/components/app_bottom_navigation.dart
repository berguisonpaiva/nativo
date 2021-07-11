import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nativo/app/modules/chamado/add-editar/add_editar_chamado_page.dart';
import 'package:nativo/app/modules/home/home_page.dart';
import 'package:nativo/app/modules/menu/menu_page.dart';

class AppBottomNavigation extends StatelessWidget {
  final int _curentIdex;
  const AppBottomNavigation(this._curentIdex);
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: Colors.white,
      color: Get.theme.primaryColor,
      index: _curentIdex,
      items: <Widget>[
        Icon(
          Icons.home,
          size: 35,
          color: Colors.white,
        ),
        Icon(
          Icons.add,
          size: 35,
          color: Colors.white,
        ),
        Icon(
          Icons.menu_rounded,
          size: 35,
          color: Colors.white,
        ),
      ],
      onTap: (index) async {
        switch (index) {
          case 0:
            Get.offAllNamed(HomePage.ROUTE_PAGE);
            break;
          case 1:
            Get.offAllNamed(AddEditarChamadoPage.ROUTE_PAGE);
            break;
          case 2:
           Get.offAllNamed(MenuPage.ROUTE_PAGE);
            break;
          default:
        }
      },
    );
  }
}
