import 'package:flutter/material.dart';
import 'package:hovedopgave_flutter_app/widgets/app_shell.dart';
import 'package:hovedopgave_flutter_app/models/school_model.dart';
import 'package:url_launcher/url_launcher.dart';

class SchoolDetailsScreen extends StatelessWidget {
  final School school;

  const SchoolDetailsScreen({super.key, required this.school});

  @override
  Widget build(BuildContext context) {
    String website = school.website.trim();
    //check if the website starts with "http://" or "https://",
    //if not, add "https://" to the beginning of the website so link works
    final websiteUrl = Uri.parse(
      website.startsWith(RegExp(r'^https?://', caseSensitive: false))
          ? website
          : 'https://$website',
    );
    return AppShell(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(school.name, style: Theme.of(context).textTheme.headlineSmall),

            if (school.imageUrl != null) ...[
              const SizedBox(height: 16),
              Center(
                child: Image.network(
                  school.imageUrl!,
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
            ],
            const SizedBox(height: 16),

            Text(school.address),
            Text('${school.zipCode} ${school.city}'),
            Text('Tlf. ${school.phoneNumber}'),
            Text('Grundlagt ${school.yearFounded}'),
            InkWell(
              onTap: () async {
                await launchUrl(websiteUrl);
              },
              child: Text(
                school.website,
                style: const TextStyle(color: Colors.blue),
              ),
            ),
            Text(school.email),
            const SizedBox(height: 16),
            
            Text('Klassetrin: ${school.levelStart} - ${school.levelEnd} klasse'),
            Text('Antal klassetrin: ${school.numberOfClasses}'),
            Text('Klassekvotient: ${school.classQuota}'),
            Text('Antal elever: ${school.numberOfStudents}'),
            Text('Antal elever i SFO: ${school.numberOfStudentsInSFO}'),

            if (school.titleText != null) ...[
              const SizedBox(height: 16),
              Text(
                school.titleText!,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
            if (school.descriptionText != null) ...[
              const SizedBox(height: 4),
              Text(school.descriptionText!),
              const SizedBox(height: 8),
            ],

            const Divider(
              color: Color.fromRGBO(188, 49, 43, 1),
            ),
          ],
        ),
      ),
    );
  }
}
