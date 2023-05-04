import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:likealocal_app_platform/core/auth/providers/auth_provider.dart';
import 'package:likealocal_app_platform/core/router/router_provider.dart';
import 'package:likealocal_app_platform/core/theme/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  init();
  runApp(const ProviderScope(child: MyApp()));
}

/// 앱 초기화
void init() async {
  /// .env 파일 로드하기
  await dotenv.load(fileName: ".env");
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    ref.read(themeProvider).init();
    ref.read(authProvider).init();
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routerProvider);
    final theme = ref.watch(themeProvider);

    return MaterialApp.router(
      title: 'Likealocal APP',
      theme: FlexThemeData.light(scheme: FlexScheme.gold, useMaterial3: true),
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.red, useMaterial3: true),
      themeMode:
          theme.themeType == ThemeType.dark ? ThemeMode.dark : ThemeMode.light,

      /// 라우터 설정
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      routerDelegate: router.routerDelegate,
    );
  }
}
