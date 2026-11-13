import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hovedopgave_flutter_app/main.dart';
import 'package:hovedopgave_flutter_app/widgets/filter_sheet.dart';

void main() {
  Future<void> verifyLogoResetsFilters(
    WidgetTester tester,
    int logoIndex,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.tune));
    await tester.pumpAndSettle();
    await tester.tap(find.textContaining('Region Hovedstaden'));
    await tester.tap(find.text('Anvend filter'));
    await tester.pumpAndSettle();

    final logo = find.byType(Image).at(logoIndex);
    await tester.tap(logo);
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.tune));
    await tester.pumpAndSettle();

    final filterSheet = tester.widget<FilterSheet>(find.byType(FilterSheet));
    expect(filterSheet.isGrundskole, isFalse);
    expect(filterSheet.isGymnasial, isFalse);
    expect(filterSheet.selectedRegions, isEmpty);
    expect(filterSheet.postalCodeRange, const RangeValues(1000, 9999));
  }

  testWidgets('Grundskoler drawer option activates the filter', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Open navigation menu'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Grundskoler'));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.tune));
    await tester.pumpAndSettle();

    final filterSheet = tester.widget<FilterSheet>(find.byType(FilterSheet));
    expect(filterSheet.isGrundskole, isTrue);
  });

  testWidgets('main logo navigates to main and resets filters', (tester) async {
    await verifyLogoResetsFilters(tester, 0);
  });

  testWidgets('round logo navigates to main and resets filters', (
    tester,
  ) async {
    await verifyLogoResetsFilters(tester, 1);
  });
}
