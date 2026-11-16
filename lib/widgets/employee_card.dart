import 'package:flutter/material.dart';
import 'package:hovedopgave_flutter_app/models/employee_model.dart';

class EmployeeCard extends StatelessWidget {
  final Employee employee;

  //constructor
  const EmployeeCard({
    super.key,
    required this.employee,
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
              employee.imageUrl ?? 'https://via.placeholder.com/800x400',
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
                    employee.role,
                    style: textStyle,
                  ),
                  Text(
                    employee.name,
                    style: titleStyle,
                  ),
                  
                  const Divider(
                    color: Color(0xFFE5E5E5),
                  ),
                  if (employee.email != null && employee.email!.isNotEmpty)
                    Text(
                      employee.email!,
                      style: textStyle,
                    ),
                  if (employee.phoneNumber != null && employee.phoneNumber!.isNotEmpty)
                    Text(
                      employee.phoneNumber!,
                      style: textStyle,
                    ),
                  if (employee.yearEmployed != null || employee.yearAppointed != null || employee.other != null)
                    Text(
                      employee.yearEmployed != null ? 'Ansat: ${employee.yearEmployed}' : '',
                      style: textStyle,
                    ),
                  if (employee.yearAppointed != null || employee.other != null)
                    Text(
                      employee.yearAppointed != null ? 'Tiltrådt: ${employee.yearAppointed}' : '',
                      style: textStyle,
                    ),
                  if (employee.other != null && employee.other!.isNotEmpty)
                    Text(
                      'Andet: ${employee.other}',
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

