import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nativo/app/components/app_bottom_navigation.dart';

import 'menu_controller.dart';

class MenuPage extends GetView<MenuController> {
  static const ROUTE_PAGE = '/menu';
  static const int NAVIGATION_BAR_INDEX = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
      ),
      bottomNavigationBar: AppBottomNavigation(NAVIGATION_BAR_INDEX),
      body: Container(
        child: Column(
          children: [
            IconButton(
                onPressed: () => controller.sair(),
                icon: Icon(
                  Icons.exit_to_app,
                  size: 50,
                ))
          ],
        ),
      ),
    );
  }
}
