import 'package:flutter/material.dart';
import 'package:hovedopgave_flutter_app/models/boardmember_model.dart';

class BoardMemberCard extends StatelessWidget {
  final BoardMember boardMember;

  //constructor
  const BoardMemberCard({
    super.key,
    required this.boardMember,
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
              boardMember.imageUrl,
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
                    boardMember.name,
                    style: titleStyle,
                  ),
                  Text(
                    boardMember.role,
                    style: textStyle,
                  ),
                  const Divider(
                    color: Color(0xFFE5E5E5),
                  ),
                  Text(
                    boardMember.email,
                    style: textStyle,
                  ),
                  Text(
                    boardMember.phoneNumber,
                    style: textStyle,
                  ),
                  Text(
                    boardMember.description ?? '',
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

