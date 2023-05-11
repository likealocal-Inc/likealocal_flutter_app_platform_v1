import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:likealocal_app_platform/modules/home/provider/home_provider.dart';
import 'package:likealocal_app_platform/modules/home/utiles/home_page_bottom_navigation_utils.dart';
import 'package:likealocal_app_platform/modules/home/views/widgets/app_bar_widget.dart';

/// 홈페이지
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final homeProviderWatch = ref.watch(homeProvider);

    return Scaffold(
      appBar: AppBarWidget.get(ref, "Home Screen"),
      body: IndexedStack(
        index: homeProviderWatch.pageIndex,
        children: HomePageBottomNavigationUtils.getpages(),
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: homeProviderWatch.pageIndex,
        onTap: (index) {
          homeProviderWatch.pageMove(index);
        },
        items:
            HomePageBottomNavigationUtils.getIcons(homeProviderWatch.pageIndex),
      ),
    );
  }
}
