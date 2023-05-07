import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:likealocal_app_platform/modules/auth/providers/auth_provider.dart';
import 'package:likealocal_app_platform/core/error/error_page.dart';
import 'package:likealocal_app_platform/core/router/router_constatnts.dart';
import 'package:likealocal_app_platform/core/utils/enum_shared_preferences.dart';
import 'package:likealocal_app_platform/modules/home/views/home_screen.dart';
import 'package:likealocal_app_platform/modules/auth/views/login/login_screen.dart';
import 'package:likealocal_app_platform/modules/splash/views/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GlobalKey<NavigatorState> _rootNavigator =
    GlobalKey(debugLabel: globalKeyRoot);

/// 라우터 페이지 생성 함수
GoRoute makeGoRoute(RouterName routerName, Widget widget) {
  return GoRoute(
      path: makePath(routerName),
      name: routerName.name,
      builder: (context, state) => widget);
}

final routerProvider = Provider<GoRouter>((ref) {
  final authProviderRead = ref.read(authProvider);

  return GoRouter(
      navigatorKey: _rootNavigator,
      refreshListenable: authProviderRead,
      initialLocation: makePath(RouterName.login),
      redirect: (context, state) async {
        // 스플래쉬 화면 요청은 무조건 skip
        if (state.location == makePath(RouterName.splash)) {
          return null;
        }

        SharedPreferences sharedPreference =
            await SharedPreferences.getInstance();
        var isLogin =
            sharedPreference.getBool(SharedPreferencesKeys.isLoginKey.name);

        // 로그인이 필요한 페이지부터 로그인 체크
        if (state.location == makePath(RouterName.home)) {
          if (isLogin == null || isLogin == false) {
            return makePath(RouterName.login);
          }
          var token =
              sharedPreference.getString(SharedPreferencesKeys.tokenKey.name);

          if (token == null || token == '') {
            sharedPreference.setBool(
                SharedPreferencesKeys.isLoginKey.name, false);
            return makePath(RouterName.login);
          }

          return null;
        }

        // 로그인 페이지 일때 처리
        if (state.location == makePath(RouterName.login)) {
          // 로그인이 되어 있을때 -> 홈으로 이동

          if (isLogin != null && isLogin) {
            return makePath(RouterName.home);
          } else {
            return makePath(RouterName.login);
          }
        }
        return null;
      },
      errorBuilder: (context, state) => RouteErrorPage(
            error: state.error,
            key: state.pageKey,
          ),
      routes: [
        makeGoRoute(RouterName.splash, const SplashScreen()),
        makeGoRoute(RouterName.login, const LoginScreen()),
        makeGoRoute(RouterName.home, const HomeScreen()),
      ]);
});
