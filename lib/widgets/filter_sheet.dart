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
  RangeValues _postalCodeRange = const RangeValues(1000, 9999);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Type',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Grundskoler'),
            value: isGrundskole,
            onChanged: (value) {  
              setState(() {
                isGrundskole = value ?? false;
              });
            },
          ),
           CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Gymnasiale uddannelser'),
            value: isGymnasial,
            onChanged: (value) {
              setState(() {
                isGymnasial = value ?? false;
              });
            },
          ),

          const SizedBox(height: 16),

          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Region',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Region Hovedstaden'),
            value: false,
            onChanged: (value) {
              setState(() {
                // Handle checkbox state change
              });
            },
          ),
           CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Region Midtjylland'),
            value: false,
            onChanged: (value) {
              setState(() {
                // Handle checkbox state change
              });
            },
          ),
           CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Region Nordjylland'),
            value: false,
            onChanged: (value) {
              setState(() {
                // Handle checkbox state change
              });
            },
          ),
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Region Sjælland'),
            value: false,
            onChanged: (value) {
              setState(() {
                // Handle checkbox state change
              });
            },
          ),
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Region Syddanmark'),
            value: false,
            onChanged: (value) {
              setState(() {
                // Handle checkbox state change
              });
            },
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
                  '${_postalCodeRange.start.round()} - ${_postalCodeRange.end.round()}',
                  style: Theme.of(context).textTheme.bodyLarge,
                )
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
          )
        ],
      ),
    );
  }
}