import 'package:flutter/material.dart';
import 'package:hovedopgave_flutter_app/models/secretary_model.dart';

class SecretaryCard extends StatelessWidget {
  final Secretary secretary;

  //constructor
  const SecretaryCard({
    super.key,
    required this.secretary,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final textStyle = textTheme.bodyMedium?.copyWith(
      fontFamily: 'Segoe UI',
      fontWeight: FontWeight.w300,
      fontSize: 16,
      color: const Color(0xFF535353),
    );
    final titleStyle = textTheme.titleLarge?.copyWith(
      fontFamily: 'Segoe UI',
      fontWeight: FontWeight.w500,
      fontSize: 18,
      color: const Color(0xFF535353),
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 32.0), // Controls the space between cards
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Profile Picture
            Image.network(
              secretary.imageUrl,
              width: 100,
              height: 120,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 12),

            // 2. Vertical Red Divider
            Container(
              width: 2,
              color: const Color(0xFF9E1B1E),
            ),
            const SizedBox(width: 16),

            // 3. Information Box
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    secretary.name,
                    style: titleStyle,
                  ),
                  Text(
                    secretary.role,
                    style: textStyle,
                  ),
                  const Divider(
                    color: Color(0xFFE5E5E5),
                  ),
                  Text(
                    secretary.email,
                    style: textStyle,
                  ),
                  Text(
                    secretary.phoneNumber,
                    style: textStyle,
                  ),
                  Text(
                    secretary.responsibilityArea ?? '',
                    style: textStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

