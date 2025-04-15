import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mojtrsat/main.dart' as app;

void main() {

    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    testWidgets('Testing login ', (WidgetTester tester) async {

      app.main();

      await tester.pumpAndSettle();

      final emailField = find.byType(TextField).at(0);
      final passwordField = find.byType(TextField).at(1);
      final loginButton = find.byType(ElevatedButton).at(0);

      await tester.enterText(emailField, 'test@gmail.com');
      await tester.enterText(passwordField, 'test123');
      await tester.tap(loginButton);

      await tester.pumpAndSettle();


    }
    );

    
  }
