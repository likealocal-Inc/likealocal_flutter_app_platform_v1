import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:likealocal_app_platform/modules/auth/providers/auth_provider.dart';
import 'package:likealocal_app_platform/modules/home/views/pages/bottom_tab_bar_pages.dart';
import 'package:likealocal_app_platform/modules/home/views/widgets/app_bar_widget.dart';

/// 홈페이지
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  // // 페이지 인덱스
  int _pageIndex = 0;

  // // 페이지 변경
  void onPageChange(int pageIndex) {
    setState(() {});
    _pageIndex = pageIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget.get(ref, "Home Screen"),
      body: IndexedStack(
        index: _pageIndex,
        children: BottomTabBarPages.pages,
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: _pageIndex,
        onTap: onPageChange,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                  _pageIndex == 0 ? Icons.home_filled : Icons.home_outlined)),
          BottomNavigationBarItem(
              icon: Icon(_pageIndex == 1 ? Icons.map : Icons.map_outlined)),
        ],
      ),
    );
  }
}
