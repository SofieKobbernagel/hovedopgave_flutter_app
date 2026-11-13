import 'package:flutter/material.dart';
import 'package:hovedopgave_flutter_app/widgets/app_shell.dart';
import 'package:hovedopgave_flutter_app/models/secretary_model.dart';
import 'package:hovedopgave_flutter_app/widgets/secretary_card.dart';

class SecretariatScreen extends StatelessWidget {
  const SecretariatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShell(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Danmarks Private Skolers sekretariat ligger i København. Sekretariatets medarbejdere har faglig ekspertise inden for skolerådgivning, kommunikation, interessevaretagelse og kursusvirksomhed.',
              style: Theme.of(context).textTheme.headlineSmall
                  ?.copyWith(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 16),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: secretariatMembers.length,
              itemBuilder: (context, index) {
                final secretariatMember = secretariatMembers[index];
                return SecretaryCard(secretary: secretariatMember);
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Mockdata
final secretariatMembers = [
  Secretary(
    imageUrl: 'https://via.placeholder.com/800x400',
    name: 'Secretariat 1',
    role: 'Sekretariatschef',
    email: 'sm1@privateskoler.dk',
    phoneNumber: '40 01 01 01',
    responsibilityArea: 'Sekretariat',
  ),
  Secretary(
    imageUrl: 'https://via.placeholder.com/800x400',
    name: 'Secretariat 2',
    role: 'Sekretariatsmedarbejder',
    email: 'sm2@privateskoler.dk',
    phoneNumber: '40 01 01 02',
    responsibilityArea: 'Sekretariat',
  ),
];
