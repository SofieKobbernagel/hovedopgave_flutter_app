import 'package:flutter/material.dart';
import 'package:hovedopgave_flutter_app/widgets/app_shell.dart';

class SecretariatScreen extends StatelessWidget {
  const SecretariatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppShell(
      body: Center(child: Text('Secretariat content goes here.')),
    );
  }
}
