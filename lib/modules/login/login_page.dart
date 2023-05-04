import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:likealocal_app_platform/config/models/api_login_model.dart';
import 'package:likealocal_app_platform/config/types/login_type.dart';
import 'package:likealocal_app_platform/core/auth/providers/auth_provider.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final authProviderWatch = ref.watch(authProvider);
    final mgs = ref.watch(authProvider).getMessage();
    return SafeArea(
      child: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                authProviderWatch.login(
                  ApiLoginModel(
                    loginType: LoginType.EMAIL,
                    params: ApiEmailLoginParam(
                      email: "test@gmail.com",
                      password: "12341234",
                    ),
                  ),
                );
              },
              child: const Text(
                "LOGIN",
                style: TextStyle(color: Colors.black),
              )),
          Text(
            "good $mgs",
            style: const TextStyle(color: Colors.yellow),
          )
        ],
      ),
    );
  }
}
