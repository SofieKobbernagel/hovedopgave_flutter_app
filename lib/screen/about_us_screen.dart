import 'package:flutter/material.dart';
import 'package:hovedopgave_flutter_app/widgets/app_shell.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppShell(
      body: Center(child: Text('About us content goes here.')),
    );
  }
}