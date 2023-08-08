import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/shared/widgets/responsive.dart';

void main() {
  group('Responsive', () {
    testWidgets('renders desktop view', (widgetTester) async {
      // Setup
      final size = Size(Responsive.desktopBreakpoint + 1, 1000);
      await widgetTester.binding.setSurfaceSize(size);
      widgetTester.view.physicalSize = size;
      widgetTester.view.devicePixelRatio = 1.0;

      // Run
      await widgetTester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Responsive(
              mobile: Text('mobile'),
              tablet: Text('tablet'),
              desktop: Text('desktop'),
            ),
          ),
        ),
      );

      await widgetTester.pumpAndSettle();

      // Verify
      expect(find.text('desktop'), findsOneWidget);
    });

    testWidgets('renders tablet view', (widgetTester) async {
      // Setup
      final size = Size(Responsive.desktopBreakpoint - 1, 1000);
      await widgetTester.binding.setSurfaceSize(size);
      widgetTester.view.physicalSize = size;
      widgetTester.view.devicePixelRatio = 1.0;

      // Run
      await widgetTester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Responsive(
              mobile: Text('mobile'),
              tablet: Text('tablet'),
              desktop: Text('desktop'),
            ),
          ),
        ),
      );

      await widgetTester.pumpAndSettle();

      // Verify
      expect(find.text('tablet'), findsOneWidget);
    });

    testWidgets('renders mobile view', (widgetTester) async {
      // Setup
      final size = Size(Responsive.mobileBreakpoint - 1, 1000);
      await widgetTester.binding.setSurfaceSize(size);
      widgetTester.view.physicalSize = size;
      widgetTester.view.devicePixelRatio = 1.0;

      // Run
      await widgetTester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Responsive(
              mobile: Text('mobile'),
              tablet: Text('tablet'),
              desktop: Text('desktop'),
            ),
          ),
        ),
      );

      await widgetTester.pumpAndSettle();

      // Verify
      expect(find.text('mobile'), findsOneWidget);
    });
  });
}
