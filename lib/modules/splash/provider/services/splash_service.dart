import 'package:flutter_riverpod/flutter_riverpod.dart';

final spalshService = Provider((ref) => SplashService());

class SplashService {
  check() async {
    // 1. 로그인 O -> home 화면
    // 2. 로그인 X -> login 화면
  }
}
