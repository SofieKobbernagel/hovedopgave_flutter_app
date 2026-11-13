import 'package:flutter/material.dart';
import 'package:hovedopgave_flutter_app/widgets/app_shell.dart';
import 'package:hovedopgave_flutter_app/models/boardmember_model.dart';
import 'package:hovedopgave_flutter_app/widgets/boardmember_card.dart';

class BoardScreen extends StatelessWidget {
  const BoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShell(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Foreningen Danmarks Private Skoler – grundskoler og gymnasier ledes af en bestyrelse, der vælges ved foreningens årsmøde i henhold til vedtægterne.',
              style: Theme.of(context).textTheme.headlineSmall
                  ?.copyWith(fontSize: 20, fontWeight: FontWeight.w300),
            ),
            SizedBox(height: 16),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: boardMembers.length,
              itemBuilder: (context, index) {
                final boardMember = boardMembers[index];
                return BoardMemberCard(boardMember: boardMember);
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Mockdata
final boardMembers = [
  BoardMember(
    imageUrl: 'https://via.placeholder.com/800x400',
    name: 'Board Member 1',
    role: 'Bestyrelsesmedarbejder',
    email: 'bm1@privateskoler.dk',
    phoneNumber: '40 01 01 01',
    description: 'Bestyrelsesformand',
  ),
  BoardMember(
    imageUrl: 'https://via.placeholder.com/800x400',
    name: 'Board Member 2',
    role: 'Bestyrelsesmedarbejder',
    email: 'bm2@privateskoler.dk',
    phoneNumber: '40 01 01 02',
    description: 'Bestyrelsesnæstformand',
  ),
  BoardMember(
    imageUrl: 'https://via.placeholder.com/800x400',
    name: 'Board Member 3',
    role: 'Bestyrelsesmedarbejder',
    email: 'bm3@privateskoler.dk',
    phoneNumber: '40 01 01 03',
    description: 'Bestyrelsesmedlem',
  ),
  BoardMember(
    imageUrl: 'https://via.placeholder.com/800x400',
    name: 'Board Member 4',
    role: 'Bestyrelsesmedarbejder',
    email: 'bm4@privateskoler.dk',
    phoneNumber: '40 01 01 04',
    description: 'Bestyrelsesmedlem',
  ),
];
