import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:likealocal_app_platform/modules/auth/providers/auth_provider.dart';

class AppBarWidget {
  static AppBar get(WidgetRef ref, String title) {
    final authProviderWatch = ref.watch(authProvider);
    return AppBar(
      title: Text(title),
      actions: [
        IconButton(
          onPressed: authProviderWatch.logout,
          icon: const Icon(Icons.logout),
          tooltip: "로그아웃",
        )
      ],
    );
  }
}
