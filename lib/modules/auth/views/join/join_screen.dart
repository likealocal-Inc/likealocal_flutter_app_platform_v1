import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:likealocal_app_platform/modules/auth/models/login/login_api_request_model.dart';
import 'package:likealocal_app_platform/modules/auth/types/login_type.dart';
import 'package:likealocal_app_platform/modules/auth/providers/auth_provider.dart';

class JoinScreen extends ConsumerStatefulWidget {
  const JoinScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _JoinScreenState();
}

class _JoinScreenState extends ConsumerState<JoinScreen> {
  @override
  Widget build(BuildContext context) {
    final authProviderWatch = ref.watch(authProvider);
    final mgs = ref.watch(authProvider).getMessage();

    return SafeArea(
      child: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                authProviderWatch.join();
              },
              child: const Text(
                "JOIN",
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
