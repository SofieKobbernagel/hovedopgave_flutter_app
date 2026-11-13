import 'package:flutter/material.dart';

class FilterSheet extends StatelessWidget {
  const FilterSheet({
    super.key,
    required this.isGrundskole,
    required this.isGymnasial,
    required this.selectedRegions,
    required this.postalCodeRange,
    required this.onGrundskoleChanged,
    required this.onGymnasialChanged,
    required this.onRegionChanged,
    required this.onPostalCodeRangeChanged,
    required this.onReset,
  });

  final bool isGrundskole;
  final bool isGymnasial;
  final Set<String> selectedRegions;
  final RangeValues postalCodeRange;
  final ValueChanged<bool> onGrundskoleChanged;
  final ValueChanged<bool> onGymnasialChanged;
  final void Function(String region, bool selected) onRegionChanged;
  final ValueChanged<RangeValues> onPostalCodeRangeChanged;
  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    return Container(
      //max height on screen
      height: MediaQuery.of(context).size.height * 0.85,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //small mark at top that makes it clear you can tap out
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

                  Material(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(8),
                    child: CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('  Grundskoler'),
                      value: isGrundskole,
                      onChanged: (value) => onGrundskoleChanged(value ?? false),
                    ),
                  ),

                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('  Gymnasiale uddannelser'),
                    value: isGymnasial,
                    onChanged: (value) => onGymnasialChanged(value ?? false),
                  ),

                  const SizedBox(height: 16),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Region',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),

                  Material(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(8),
                    child: CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('  Region Hovedstaden'),
                      value: selectedRegions.contains('Hovedstaden'),
                      onChanged: (value) =>
                          onRegionChanged('Hovedstaden', value ?? false),
                    ),
                  ),

                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('  Region Midtjylland'),
                    value: selectedRegions.contains('Midtjylland'),
                    onChanged: (value) =>
                        onRegionChanged('Midtjylland', value ?? false),
                  ),

                  Material(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(8),
                    child: CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('  Region Nordjylland'),
                      value: selectedRegions.contains('Nordjylland'),
                      onChanged: (value) =>
                          onRegionChanged('Nordjylland', value ?? false),
                    ),
                  ),

                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('  Region Sjælland'),
                    value: selectedRegions.contains('Sjælland'),
                    onChanged: (value) =>
                        onRegionChanged('Sjælland', value ?? false),
                  ),

                  Material(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(8),
                    child: CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('  Region Syddanmark'),
                      value: selectedRegions.contains('Syddanmark'),
                      onChanged: (value) =>
                          onRegionChanged('Syddanmark', value ?? false),
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
                          '${postalCodeRange.start.round()} - '
                          '${postalCodeRange.end.round()}',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),

                  RangeSlider(
                    values: postalCodeRange,
                    min: 1000,
                    max: 9999,
                    onChanged: onPostalCodeRangeChanged,
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
                  onPressed: onReset,
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
