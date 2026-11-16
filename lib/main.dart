import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hovedopgave_flutter_app/screen/about_us_screen.dart';
import 'package:hovedopgave_flutter_app/screen/board_screen.dart';
import 'package:hovedopgave_flutter_app/screen/secretariat_screen.dart';
import 'package:hovedopgave_flutter_app/widgets/app_shell.dart';
import 'package:hovedopgave_flutter_app/models/school_model.dart';
import 'package:hovedopgave_flutter_app/widgets/school_card.dart';
import 'package:hovedopgave_flutter_app/screen/school_details_screen.dart';
import 'package:hovedopgave_flutter_app/widgets/filter_sheet.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

final _denmarkBounds = LatLngBounds(
  const LatLng(54.5, 8.0), // Sydvest
  const LatLng(57.9, 12.8), // Nordøst
);

void main() {
  runApp(DevicePreview(builder: (context) => const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(fontFamily: 'Segoe UI');
    final titleTextTheme = ThemeData(fontFamily: 'PF Handbook Pro').textTheme;

    return MaterialApp(
      title: 'Danmarks Private Skoler',
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: theme.copyWith(
        textTheme: theme.textTheme.copyWith(
          displayLarge: titleTextTheme.displayLarge,
          displayMedium: titleTextTheme.displayMedium,
          displaySmall: titleTextTheme.displaySmall,
          headlineLarge: titleTextTheme.headlineLarge,
          headlineMedium: titleTextTheme.headlineMedium,
          headlineSmall: titleTextTheme.headlineSmall,
          titleLarge: titleTextTheme.titleLarge,
          titleMedium: titleTextTheme.titleMedium,
          titleSmall: titleTextTheme.titleSmall,
        ),
      ),
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
        '/main': (context) {
          final initialGrundskole =
              ModalRoute.of(context)?.settings.arguments == 'grundskoler';
          final initialGymnasial =
              ModalRoute.of(context)?.settings.arguments == 'gymnasier';
          return MyHomePage(
            title: 'Danmarks Private Skoler',
            initialGrundskole: initialGrundskole,
            initialGymnasial: initialGymnasial,
          );
        },
      },
      home: const MyHomePage(title: 'Danmarks Private Skoler'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
    this.initialGrundskole = false,
    this.initialGymnasial = false,
  });

  final String title;
  final bool initialGrundskole;
  final bool initialGymnasial;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //setup for map
  final MapController mapController = MapController();
  late final MapOptions _mapOptions = MapOptions(
    initialCenter: const LatLng(56.1, 10.5),
    initialZoom: 6.4,
    cameraConstraint: CameraConstraint.containCenter(bounds: _denmarkBounds),
    minZoom: 6.4,
    maxZoom: 18,
  );
  // Stores the current search and filter values.
  // They start empty/default when the page is opened.
  String searchQuery = '';
  bool isGrundskole = false;
  bool isGymnasial = false;
  Set<String> selectedRegions = <String>{};
  RangeValues postalCodeRange = const RangeValues(1000, 9999);

  @override
  void initState() {
    super.initState();
    isGrundskole = widget.initialGrundskole;
    isGymnasial = widget.initialGymnasial;
  }

  // Adds or removes a region from the selected region filters.
  void _setRegionSelected(String region, bool selected) {
    setState(() {
      if (selected) {
        selectedRegions = {...selectedRegions, region};
      } else {
        selectedRegions = {...selectedRegions}..remove(region);
      }
    });
  }

  //used to reset filter options
  void _resetFilters() {
    setState(() {
      isGrundskole = false;
      isGymnasial = false;
      selectedRegions = <String>{};
      postalCodeRange = const RangeValues(1000, 9999);
    });
  }

  // This method is rerun every time setState is called, for instance as done
  @override
  Widget build(BuildContext context) {
    // only active when exactly one of the options is selected.
    //If both are selected or both are unselected, all school types should be shown.
    final hasSchoolTypeFilter = isGrundskole != isGymnasial;

    // Create a new list containing only schools that match all active filters.
    final filteredSchools = schools.where((school) {
      // School type matches when:
      // - no school type filter is active, OR
      // - the school's type matches the selected type
      final matchesSchoolType =
          !hasSchoolTypeFilter || school.isGrundskole == isGrundskole;
      // Region matches when:
      // - no regions are selected, OR
      // - the school's region is one of the selected regions
      final matchesRegion =
          selectedRegions.isEmpty || selectedRegions.contains(school.region);
      // Checks if school's zip code falls within the selected postal code range
      final matchesPostalCode =
          school.zipCode >= postalCodeRange.start &&
          school.zipCode <= postalCodeRange.end;
      // Search matches when the school's name contains the text
      // entered in the search bar (case-insensitive)
      final matchesSearch = school.name.toLowerCase().contains(
        searchQuery.toLowerCase(),
      );

      // A school is included in the filtered list only if it passes
      // all active filters
      return matchesSchoolType &&
          matchesRegion &&
          matchesPostalCode &&
          matchesSearch;
    }).toList();
    //sort the filtered schools alphabetically by name
    filteredSchools.sort(
      (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
    );

    return AppShell(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              //map
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.45,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: FlutterMap(
                    mapController: mapController,
                    options: _mapOptions,
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName:
                            'com.example.hovedopgave_flutter_app',
                      ),
                      MediaQuery.removePadding(
                        context: context,
                        removeBottom: true,
                        child: SimpleAttributionWidget(
                          alignment: Alignment.bottomRight,
                          source: const Text('OpenStreetMap contributors'),
                          onTap: () {
                            launchUrl(
                              Uri.parse(
                                'https://www.openstreetmap.org/copyright',
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _SearchFilterHeaderDelegate(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
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
                    const SizedBox(width: 12),
                    IconButton(
                      iconSize: 40,
                      icon: const Icon(Icons.tune),
                      onPressed: () {
                        var sheetIsGrundskole = isGrundskole;
                        var sheetIsGymnasial = isGymnasial;
                        var sheetSelectedRegions = {...selectedRegions};
                        var sheetPostalCodeRange = postalCodeRange;

                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return StatefulBuilder(
                              builder: (context, setSheetState) {
                                return FilterSheet(
                                  isGrundskole: sheetIsGrundskole,
                                  isGymnasial: sheetIsGymnasial,
                                  selectedRegions: sheetSelectedRegions,
                                  postalCodeRange: sheetPostalCodeRange,
                                  onGrundskoleChanged: (value) {
                                    setSheetState(
                                      () => sheetIsGrundskole = value,
                                    );
                                    setState(() => isGrundskole = value);
                                  },
                                  onGymnasialChanged: (value) {
                                    setSheetState(
                                      () => sheetIsGymnasial = value,
                                    );
                                    setState(() => isGymnasial = value);
                                  },
                                  onRegionChanged: (region, selected) {
                                    setSheetState(() {
                                      if (selected) {
                                        sheetSelectedRegions = {
                                          ...sheetSelectedRegions,
                                          region,
                                        };
                                      } else {
                                        sheetSelectedRegions = {
                                          ...sheetSelectedRegions,
                                        }..remove(region);
                                      }
                                    });
                                    _setRegionSelected(region, selected);
                                  },
                                  onPostalCodeRangeChanged: (value) {
                                    setSheetState(
                                      () => sheetPostalCodeRange = value,
                                    );
                                    setState(() => postalCodeRange = value);
                                  },
                                  onReset: () {
                                    setSheetState(() {
                                      sheetIsGrundskole = false;
                                      sheetIsGymnasial = false;
                                      sheetSelectedRegions = <String>{};
                                      sheetPostalCodeRange = const RangeValues(
                                        1000,
                                        9999,
                                      );
                                    });
                                    _resetFilters();
                                  },
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
        body: ListView.builder(
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
    );
  }
}

// Keeps the search bar and filter button pinned while the map scrolls away.
class _SearchFilterHeaderDelegate extends SliverPersistentHeaderDelegate {
  const _SearchFilterHeaderDelegate({required this.child});

  final Widget child;

  // A fixed height prevents the pinned header from shrinking as the page scrolls.
  @override
  double get minExtent => 88;

  @override
  double get maxExtent => 88;

  // Adds a background so scrolling school cards do not show through the header.
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      elevation: overlapsContent ? 2 : 0,
      child: child,
    );
  }

  // Rebuilds the header when the sliver supplies an updated delegate.
  @override
  bool shouldRebuild(_SearchFilterHeaderDelegate oldDelegate) => true;
}

//mockdata DELETE later
final schools = [
  School(
    name: 'Allerød Privatskole',
    address: 'Sortemosevej 15',
    zipCode: 3450,
    city: 'Allerød',
    region: 'Hovedstaden',
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
    region: 'Hovedstaden',
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
    zipCode: 4140,
    city: 'Borup',
    region: 'Sjælland',
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
    region: 'Nordjylland',
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
  School(
    name: 'Københavns private gymnasium',
    address: 'skolevej 4',
    zipCode: 2000,
    city: 'København',
    region: 'Hovedstaden',
    phoneNumber: '30 30 30 30',
    yearFounded: 1980,
    website: 'eksempel.dk',
    email: 'info@eksempel.dk',
    numberOfClasses: 40,
    levelStart: '1.G',
    levelEnd: '3.G',
    classQuota: '24',
    numberOfStudents: 2000,
    numberOfStudentsInSFO: 0,
    titleText: 'Velkommen til et Gymnasie med fokus på udvikling og læring',
    descriptionText: 'Vi er en stor skole i hjertet af kbh.',
  ),
];
