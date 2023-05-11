import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:likealocal_app_platform/modules/home/utiles/bottom_tab_bar_utils.dart';
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
        children: BottomTabBarUtils.getpages(),
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: _pageIndex,
        onTap: onPageChange,
        items: BottomTabBarUtils.getIcons(_pageIndex),
      ),
    );
  }
}
