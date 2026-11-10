import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:hovedopgave_flutter_app/screen/about_us_screen.dart';
import 'package:hovedopgave_flutter_app/screen/board_screen.dart';
import 'package:hovedopgave_flutter_app/screen/secretariat_screen.dart';
import 'package:hovedopgave_flutter_app/widgets/app_shell.dart';
import 'package:hovedopgave_flutter_app/models/school_model.dart';
import 'package:hovedopgave_flutter_app/widgets/school_card.dart';
import 'package:hovedopgave_flutter_app/screen/school_details_screen.dart';

void main() {
  runApp(DevicePreview(builder: (context) => MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Danmarks Private Skoler',
      routes: {
        '/about-us': (context) => const AboutUsScreen(),
        '/board': (context) => const BoardScreen(),
        '/secretariat': (context) => const SecretariatScreen(),
        '/school-details': (context) {
          final school = ModalRoute.of(context)?.settings.arguments;
          if (school is! School) {
            return AppShell(
              body: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('No school was provided.'),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Back to schools'),
                    ),
                  ],
                ),
              ),
            );
          }
          return SchoolDetailsScreen(school: school);
        },
        '/main': (context) =>
            const MyHomePage(title: 'Danmarks Private Skoler'),
      },
      home: const MyHomePage(title: 'Danmarks Private Skoler'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String searchQuery = '';
  // This method is rerun every time setState is called, for instance as done
  @override
  Widget build(BuildContext context) {
    //filter schools based on the search query
    final filteredSchools = schools.where((school) {
      return school.name.toLowerCase().contains(
      searchQuery.toLowerCase(),
      );
    }).toList();
    //sort the filtered schools alphabetically by name
    filteredSchools.sort((a, b) =>
      a.name.toLowerCase().compareTo(b.name.toLowerCase()));

    return AppShell(
      //loads the list of schools from the mockdata
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Search bar
                Expanded(
                  child: SearchBar(
                    hintText: 'Søg efter skole',
                    leading: const Icon(Icons.search),
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                  ),
                ),

                const SizedBox(width: 12), //space
                // Filter button
                IconButton(
                  iconSize: 40,
                  icon: const Icon(Icons.tune),
                  onPressed: () {
                    // Open filter menu
                  },
                ),
              ],
            ),
          ),

          // School cards
          Expanded(
            child: ListView.builder(
              itemCount: filteredSchools.length,
              itemBuilder: (context, index) {
                final school = filteredSchools[index];
                return SchoolCard(
                  school: school,
                  onTap: () => Navigator.pushNamed(
                    context,
                    '/school-details',
                    arguments: school,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

//mockdata DELETE later
final schools = [
  School(
    name: 'Allerød Privatskole',
    address: 'Sortemosevej 15',
    zipCode: 3450,
    city: 'Allerød',
    phoneNumber: '48 14 00 00',
    yearFounded: 1995,
    website: 'alleroedprivatskole.dk',
    email: 'info@alleroedprivatskole.dk',
    numberOfClasses: 10,
    levelStart: '0.',
    levelEnd: '9.',
    classQuota: '22',
    numberOfStudents: 200,
    numberOfStudentsInSFO: 50,
    titleText: 'Velkommen til Allerød Privatskole',
    descriptionText:
        'En kvalitetsorienteret skole med fokus på elevernes udvikling.',
    imageUrl: 'https://via.placeholder.com/800x400',
  ),

  School(
    name: 'Amager Privatskole',
    address: 'Hornevej 1',
    zipCode: 2770,
    city: 'Kastrup',
    phoneNumber: '32 14 00 00',
    yearFounded: 1998,
    website: 'www.amagerprivatskole.dk',
    email: 'info@amagerprivatskole.dk',
    numberOfClasses: 12,
    levelStart: '0.',
    levelEnd: '10.',
    classQuota: '22',
    numberOfStudents: 250,
    numberOfStudentsInSFO: 60,
    titleText: 'Velkommen til Amager Privatskole',
  ),

  School(
    name: 'Borup Privatskole',
    address: 'Skolevej 5',
    zipCode: 8000,
    city: 'Aarhus C',
    phoneNumber: '86 12 34 56',
    yearFounded: 2000,
    website: 'https://www.borupprivatskole.dk',
    email: 'info@borupprivatskole.dk',
    numberOfClasses: 15,
    levelStart: '0.',
    levelEnd: '10.',
    classQuota: '22',
    numberOfStudents: 300,
    numberOfStudentsInSFO: 75,
  ),

  School(
    name: 'Aalborg Privatskole',
    address: 'Privatskolevej 10',
    zipCode: 9000,
    city: 'Aalborg',
    phoneNumber: '98 12 34 56',
    yearFounded: 2005,
    website: 'https://www.aalborgprivatskole.dk',
    email: 'info@aalborgprivatskole.dk',
    numberOfClasses: 15,
    levelStart: '0.',
    levelEnd: '10.',
    classQuota: '22',
    numberOfStudents: 300,
    numberOfStudentsInSFO: 75,
    titleText: 'Velkommen til Aalborg Privatskole',
    descriptionText:
        'En pædagogisk skole med fokus på elevernes udvikling og velvære.',
  ),
];
