import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:likealocal_app_platform/core/auth/providers/auth_provider.dart';
import 'package:likealocal_app_platform/core/error/error_page.dart';
import 'package:likealocal_app_platform/core/router/router_constatnts.dart';
import 'package:likealocal_app_platform/modules/login/login_page.dart';

final GlobalKey<NavigatorState> _rootNavigator =
    GlobalKey(debugLabel: globalKeyRoot);

final routerProvider = Provider<GoRouter>((ref) {
  final authProviderRead = ref.read(authProvider);
  return GoRouter(
      navigatorKey: _rootNavigator,
      refreshListenable: authProviderRead,
      initialLocation: makePath(routerNameLogin),
      redirect: (context, state) async {
        print(state.location);
        // 스플래쉬 화면 요청은 무조건 skip
        if (state.matchedLocation == makePath(routerNameSplash)) {
          return null;
        }

        // 로그인 페이지 일때 처리
        if (state.matchedLocation == makePath(routerNameLogin)) {
          // 1. 로그인이 안되어 있을때 -> 로그인페이지 유지

          // 2. 로그인이 되어 있을때 -> 홈으로 이동
        }

        return null;
      },
      errorBuilder: (context, state) => RouteErrorPage(
            error: state.error,
            key: state.pageKey,
          ),
      routes: [
        GoRoute(
          path: makePath(routerNameLogin),
          name: routerNameLogin,
          builder: (context, state) => const LoginPage(),
        )
      ]);
});
