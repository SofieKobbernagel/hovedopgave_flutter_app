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

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            secretary.imageUrl,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
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
          SizedBox(height: 16),
        ],
      ),
    );
  }
}

