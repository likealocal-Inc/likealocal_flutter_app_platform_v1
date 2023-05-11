import 'package:flutter/material.dart';
import 'package:likealocal_app_platform/modules/home/views/pages/home_page.dart';
import 'package:likealocal_app_platform/modules/home/views/pages/map_google_page.dart';
import 'package:likealocal_app_platform/modules/home/views/pages/map_naver_page.dart';
import 'package:likealocal_app_platform/modules/home/views/pages/map_webview_page.dart';

class BottomTabBarUtils {
  static List<Widget> getpages() {
    return [
      const HomePage(),
      const MapGooglePage(),
      const MapNaverPage(),
      const MapWebviewPage()
    ];
  }

  static List<BottomNavigationBarItem> getIcons(int pageIndex) {
    return [
      BottomNavigationBarItem(
          icon: Icon(pageIndex == 0 ? Icons.home_filled : Icons.home_outlined)),
      BottomNavigationBarItem(
          icon:
              Icon(pageIndex == 1 ? Icons.maps_ugc : Icons.maps_ugc_outlined)),
      BottomNavigationBarItem(
          icon: Icon(pageIndex == 2 ? Icons.map : Icons.map_outlined)),
      BottomNavigationBarItem(
          icon: Icon(pageIndex == 3
              ? Icons.maps_home_work
              : Icons.maps_home_work_outlined)),
    ];
  }
}
