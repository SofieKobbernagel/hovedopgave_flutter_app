import 'package:flutter/material.dart';
import 'package:hovedopgave_flutter_app/widgets/app_shell.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShell(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(children: [
        Text('Danmarks Private Skoler er organisation for frie og private grundskoler og gymnasiale uddannelser i hele Danmark.',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          )),
        SizedBox(height: 16),
        Text('Foreningen varetager skolernes politiske interesser over for bl.a. Folketinget og Børne- og Undervisningsministeriet. Interessevaretagelsen understøttes af foreningens kommunikationsvirksomhed og projekt- og analysearbejde.'),
        SizedBox(height: 16),
        Text('Foreningens sekretariat rådgiver skolerne i juridiske, økonomiske, ledelsesmæssige, pædagogiske- og undervisningsrelaterede spørgsmål.'),
        SizedBox(height: 16),
        Text('Foreningen har desuden en omfattende kursusvirksomhed for medlemsskolernes ledelser og bestyrelser.'),
      ])),
    );    
  }
}