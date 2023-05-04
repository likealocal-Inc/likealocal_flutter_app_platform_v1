import 'package:flutter/material.dart';

/// 에러페이지
// ignore: must_be_immutable
class RouteErrorPage extends StatelessWidget {
  final Exception? error;
  late String message;

  RouteErrorPage({Key? key, this.error}) : super(key: key) {
    if (error != null) {
      message = error.toString();
    } else {
      message = 'Error';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(message)));
  }
}
