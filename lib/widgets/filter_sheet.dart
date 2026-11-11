import 'package:flutter/material.dart';

//needed for the filter sheet to work because it updates the state of
//the filter sheet when the checkbox is clicked
class FilterSheet extends StatefulWidget {
  const FilterSheet({super.key});

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  bool isGrundskole = false;
  bool isGymnasial = false;
  String? selectedRegion;
  RangeValues _postalCodeRange = const RangeValues(1000, 9999);

  void _setSchoolType(bool? selected, {required bool grundskole}) {
    setState(() {
      if (grundskole) {
        isGrundskole = selected ?? false;
        if (isGrundskole) isGymnasial = false;
      } else {
        isGymnasial = selected ?? false;
        if (isGymnasial) isGrundskole = false;
      }
    });
  }

  void _setRegionSelected(String region, bool? selected) {
    setState(() {
      if (selected ?? false) {
        selectedRegion = region;
      } else if (selectedRegion == region) {
        selectedRegion = null;
      }
    });
  }

  void _resetFilters() {
    setState(() {
      isGrundskole = false;
      isGymnasial = false;
      selectedRegion = null;
      _postalCodeRange = const RangeValues(1000, 9999);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    'Filter',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Type',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),

                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('  Grundskoler'),
                      value: isGrundskole,
                      onChanged: (value) =>
                          _setSchoolType(value, grundskole: true),
                    ),
                  ),
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('  Gymnasiale uddannelser'),
                    value: isGymnasial,
                    onChanged: (value) =>
                        _setSchoolType(value, grundskole: false),
                  ),

                  const SizedBox(height: 16),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Region',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('  Region Hovedstaden'),
                      value: selectedRegion == 'Hovedstaden',
                      onChanged: (value) =>
                          _setRegionSelected('Hovedstaden', value),
                    ),
                  ),

                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('  Region Midtjylland'),
                    value: selectedRegion == 'Midtjylland',
                    onChanged: (value) =>
                        _setRegionSelected('Midtjylland', value),
                  ),

                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('  Region Nordjylland'),
                      value: selectedRegion == 'Nordjylland',
                      onChanged: (value) =>
                          _setRegionSelected('Nordjylland', value),
                    ),
                  ),

                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('  Region Sjælland'),
                    value: selectedRegion == 'Sjælland',
                    onChanged: (value) => _setRegionSelected('Sjælland', value),
                  ),

                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('  Region Syddanmark'),
                      value: selectedRegion == 'Syddanmark',
                      onChanged: (value) =>
                          _setRegionSelected('Syddanmark', value),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Postnummer',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          '${_postalCodeRange.start.round()} - '
                          '${_postalCodeRange.end.round()}',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),

                  RangeSlider(
                    values: _postalCodeRange,
                    min: 1000,
                    max: 9999,
                    onChanged: (value) {
                      setState(() {
                        _postalCodeRange = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _resetFilters,
                  child: const Text('Nulstil'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Anvend filter'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
