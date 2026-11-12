import 'package:flutter/material.dart';
import 'package:hovedopgave_flutter_app/models/school_model.dart';
import 'package:url_launcher/url_launcher.dart';

class SchoolCard extends StatelessWidget {
  final School school;
  final VoidCallback? onTap;

  //constructor
  const SchoolCard({
    super.key,
    //when creating a SchoolCard, you must provide a School object
    required this.school,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final cardTextStyle = textTheme.bodyMedium?.copyWith(
      color: const Color(0xFF535353),
    );
    final titleStyle = textTheme.titleLarge?.copyWith(
      fontFamily: 'PF Handbook Pro',
      fontWeight: FontWeight.w500,
      fontSize: 20,
      color: const Color(0xFF535353),
    );

    String website = school.website.trim();
    //check if the website starts with "http://" or "https://",
    //if not, add "https://" to the beginning of the website so link works
    final websiteUrl = Uri.parse(
      website.startsWith(RegExp(r'^https?://', caseSensitive: false))
          ? website
          : 'https://$website',
    );

    return Card(
      //adds space around the card
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: InkWell(onTap: onTap, //calls the onTap function when the card is tapped
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text(
              school.name,
              style: titleStyle,
            ),
            const Divider(
              color: Color.fromRGBO(188, 49, 43, 1),
              //evt. thickness
            ),
            Text(school.address, style: cardTextStyle),
            const SizedBox(
              height: 8,
            ), //adds space between the address and the zip code/city

            Text('${school.zipCode} ${school.city}', style: cardTextStyle),
            const SizedBox(height: 8),

            //link to the school's website, opens in a new tab
            InkWell(
              onTap: () async {
                await launchUrl(websiteUrl);
              },
              child: Text(
                school.website,
                style: const TextStyle(color: Color(0xFFC00000)),
              ),
            ),
          ],
          ),
        ),
      ),
    );
  }
}
