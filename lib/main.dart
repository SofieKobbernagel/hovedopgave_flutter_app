import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:hovedopgave_flutter_app/screen/about_us_screen.dart';
import 'package:hovedopgave_flutter_app/screen/board_screen.dart';
import 'package:hovedopgave_flutter_app/screen/secretariat_screen.dart';
import 'package:hovedopgave_flutter_app/widgets/app_shell.dart';
import 'package:hovedopgave_flutter_app/models/school_model.dart';
import 'package:hovedopgave_flutter_app/widgets/school_card.dart';
import 'package:hovedopgave_flutter_app/screen/school_details_screen.dart';
import 'package:hovedopgave_flutter_app/widgets/filter_sheet.dart';
import 'package:hovedopgave_flutter_app/data/mock_schools.dart';
import 'package:hovedopgave_flutter_app/widgets/map.dart';

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
              child: SizedBox(
                height:
                    MediaQuery.of(context).size.height * 0.45, //height of map
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SchoolMap(schools: schools),
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
