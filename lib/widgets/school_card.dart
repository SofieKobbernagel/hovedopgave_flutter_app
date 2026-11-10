import 'package:flutter/material.dart';
import 'package:hovedopgave_flutter_app/models/school_model.dart';

class SchoolCard extends StatelessWidget {
  final School school;

//constructor
  const SchoolCard({
    super.key, 
    //when creating a SchoolCard, you must provide a School object
    required this.school
    });

  @override
  Widget build(BuildContext context) {
    return Card(
      //adds space around the card
      margin: const EdgeInsets.symmetric(
        horizontal: 16.0, 
        vertical: 8.0
        ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              school.name,
              style: const TextStyle(
                fontSize: 24,
              ),
            ),
            const Divider(
              color: Color.fromRGBO(188, 49, 43, 1),
              //evt. thickness
            ),
            Text(school.address),
            const SizedBox(height: 8), //adds space between the address and the zip code/city

            Text(school.zipCode.toString() + ' ' + school.city),
            const SizedBox(height: 8),

            Text(school.website, 
            style: const TextStyle(color: Colors.blue)
            ),
          ],
        ),
      )
    );
  }
}