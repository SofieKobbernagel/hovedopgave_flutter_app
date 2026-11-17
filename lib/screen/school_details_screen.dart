import 'package:flutter/material.dart';
import 'package:hovedopgave_flutter_app/widgets/app_shell.dart';
import 'package:hovedopgave_flutter_app/models/school_model.dart';
import 'package:hovedopgave_flutter_app/models/employee_model.dart';
import 'package:hovedopgave_flutter_app/widgets/employee_card.dart';
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
            Text(
              school.name,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF535353),
                  ),
            ),

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
                style: const TextStyle(color: Color(0xFFC00000)),
              ),
            ),
            Text(school.email),
            const SizedBox(height: 16),
            
            Text('Klassetrin: ${school.levelStart} - ${school.levelEnd} klasse'),
            Text('Antal klassetrin: ${school.numberOfClasses}'),
            Text('Klassekvotient: ${school.classQuota}'),
            Text('Antal elever: ${school.numberOfStudents}'),
            if (school.numberOfStudentsInSFO != null)
              Text('Antal elever i SFO: ${school.numberOfStudentsInSFO}'),
            

            if (school.titleText != null) ...[
              const SizedBox(height: 16),
              Text(
                school.titleText!,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
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

            const SizedBox(height: 8),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: employeeMembers.length,
              itemBuilder: (context, index) {
                final employeeMember = employeeMembers[index];
                return EmployeeCard(employee: employeeMember);
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Mockdata
final employeeMembers = [
  Employee(
    imageUrl: 'https://via.placeholder.com/800x400',
    name: 'Ågon Ledelsen',
    role: 'Skoleleder',
    email: 'ÅL@privateskoler.dk',
    yearAppointed: 2010,
    yearEmployed: 2005,
  ),
    Employee(
    imageUrl: 'https://via.placeholder.com/800x400',
    name: 'Vicki Bertelsen',
    role: 'Viceskoleleder',
    email: 'VB@privateskoler.dk',
    phoneNumber: '01 01 01 02',
    yearEmployed: 2008,
  ),
    Employee(
    imageUrl: 'https://via.placeholder.com/800x400',
    name: 'Sofus Kindergaard',
    role: 'SFO-Leder',
    email: 'SK@privateskoler.dk',
    phoneNumber: '01 01 01 03',
    yearAppointed: 2018,
    yearEmployed: 2013,
    other: 'Ansvarlig for SFO og fritidsaktiviteter',
  ),
  Employee(
    imageUrl: 'https://via.placeholder.com/800x400',
    name: 'Betina Fore',
    role: 'Bestyrelsesformand',
    email: 'BF@privateskoler.dk',
    phoneNumber: '01 01 01 04',
  ),
];
