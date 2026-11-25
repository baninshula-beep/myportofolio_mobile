import 'package:flutter_test/flutter_test.dart';
import 'package:myportofolio_mobile/main.dart';

void main() {
  testWidgets('MyPortfolio homepage displays correctly', (
    WidgetTester tester,
  ) async {
    // Build the application.
    await tester.pumpWidget(const MyApp());

    // Verify that the application title is displayed.
    expect(find.text('MyPortfolio'), findsOneWidget);

    // Verify that the user's profile information is displayed.
    expect(find.text('NPM'), findsOneWidget);
    expect(find.text('Name'), findsOneWidget);
    expect(find.text('Class'), findsOneWidget);

    // Verify that the homepage welcome message is displayed.
    expect(find.text('Selamat datang di MyPortfolio Mobile!'), findsOneWidget);
  });
}
