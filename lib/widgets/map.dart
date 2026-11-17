import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hovedopgave_flutter_app/models/school_model.dart';
import 'package:hovedopgave_flutter_app/widgets/school_card.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

final _denmarkBounds = LatLngBounds(
  const LatLng(54.5, 8.0),
  const LatLng(57.9, 12.8),
);

class SchoolMap extends StatelessWidget {
  final List<School> schools;

  const SchoolMap({super.key, required this.schools});

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: const LatLng(56.1, 10.5),
        initialZoom: 6.4,
        cameraConstraint: CameraConstraint.containCenter(
          bounds: _denmarkBounds,
        ),
        minZoom: 6.4,
        maxZoom: 18,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.hovedopgave_flutter_app',
        ),
        MarkerLayer(
          markers: schools.map((school) {
            return Marker(
              point: LatLng(school.latitude, school.longitude),
              width: 40,
              height: 40,
              child: IconButton(
                padding: EdgeInsets.zero,
                tooltip: school.name,
                onPressed: () {
                  showDialog<void>(
                    context: context,
                    builder: (dialogContext) => Dialog(
                      child: SchoolCard(
                        school: school,
                        onTap: () {
                          Navigator.pop(dialogContext);
                          Navigator.of(context)
                              .pushNamed('/school-details', arguments: school);
                        },
                        trailing: IconButton(
                          tooltip: 'Luk',
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.pop(dialogContext),
                        ),
                      ),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 40,
                ),
              ),
            );
          }).toList(),
        ),
        MediaQuery.removePadding(
          context: context,
          removeBottom: true,
          child: SimpleAttributionWidget(
            alignment: Alignment.bottomRight,
            source: const Text('OpenStreetMap contributors'),
            onTap: () {
              launchUrl(Uri.parse('https://www.openstreetmap.org/copyright'));
            },
          ),
        ),
      ],
    );
  }
}
