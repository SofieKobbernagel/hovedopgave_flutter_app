import 'package:flutter/material.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.body, this.floatingActionButton});

  final Widget body;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: () => _goToMainAndReset(context),
          child: Image.asset('assets/images/DPS-Logo.png', height: 40),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            //inkwell is a widget that responds to touch events
            child: InkWell(
              onTap: () => _goToMainAndReset(context),
              child: Image.asset(
                'assets/images/DPS-Round-Logo.png',
                height: 50,
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              ListTile(
                leading: const Icon(Icons.stars),
                title: const Text('Medlemsskolerne'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _openRoute(context, '/main'),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                     onPressed: () => _openRoute(context, '/main'),
                      child: const Text('Alle medlemsskoler'),
                    ),
                    TextButton(
                      onPressed: () => _openRoute(
                        context,
                        '/main',
                        arguments: 'grundskoler',
                      ),
                      child: const Text('Grundskoler'),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Gymnasiale uddannelser'),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.stars),
                title: const Text('Om os'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _openRoute(context, '/about-us'),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () => _openRoute(context, '/about-us'),
                      child: const Text('Om foreningen'),
                    ),
                    TextButton(
                      onPressed: () => _openRoute(context, '/board'),
                      child: const Text('Foreningens bestyrelse'),
                    ),
                    TextButton(
                      onPressed: () => _openRoute(context, '/secretariat'),
                      child: const Text('Foreningens sekretariat'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }

  void _goToMainAndReset(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/main',
      (route) => false,
    );
  }

// Helper method to open a route and close the drawer
  void _openRoute(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    Navigator.pop(context);
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }
}
