// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in the widget tree, use the
// WidgetTester utility in the flutter_test package.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:_24_krafts/features/kyc/presentation/screens/aadhaar_verification_screen.dart';
import 'package:_24_krafts/features/profile/presentation/screens/complete_profile_screen.dart';
import 'package:_24_krafts/main.dart';
import 'package:_24_krafts/features/dashboard/presentation/screens/producer_dashboard_screen.dart';
import 'package:_24_krafts/features/auth/presentation/screens/verify_otp_screen.dart';

void main() {
  testWidgets('Login screen matches 24 Crafts copy', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(const MyApp());

    expect(find.text('Welcome Back'), findsOneWidget);
    expect(find.text('Enter your mobile number to continue'), findsOneWidget);
    expect(find.text('Send OTP'), findsOneWidget);
    expect(find.text('Sign up'), findsOneWidget);
    expect(find.text('Mobile Number'), findsOneWidget);
    expect(find.text('+91'), findsOneWidget);
  });

  testWidgets('Send OTP navigates to verify screen', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(const MyApp());
    await tester.ensureVisible(find.text('Send OTP'));
    await tester.tap(find.text('Send OTP'));
    await tester.pumpAndSettle();

    expect(find.text('Verify OTP'), findsOneWidget);
  });

  testWidgets('Verify OTP screen shows OTP field', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: VerifyOtpScreen(phone: '9999999999'),
      ),
    );

    expect(find.text('Verify OTP'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
  });

  testWidgets('Verify OTP leads to Complete Your Profile', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      const MaterialApp(
        home: VerifyOtpScreen(phone: '999'),
      ),
    );
    await tester.tap(find.text('Verify OTP'));
    await tester.pumpAndSettle();

    expect(find.text('Complete Your Profile'), findsOneWidget);
    expect(find.text('Personal Information'), findsOneWidget);
    expect(find.text('Continue'), findsOneWidget);
    expect(find.text('Save Draft'), findsOneWidget);
  });

  testWidgets('Complete profile screen smoke test', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      const MaterialApp(
        home: CompleteProfileScreen(phone: '+91 999'),
      ),
    );

    expect(find.text('Personal Information'), findsOneWidget);
    expect(find.text('Save Draft'), findsOneWidget);
    expect(find.text('Continue'), findsOneWidget);
  });

  testWidgets('Continue opens Aadhaar Verification', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      const MaterialApp(
        home: CompleteProfileScreen(phone: '+91 999'),
      ),
    );
    await tester.ensureVisible(find.text('Continue'));
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    expect(find.text('Aadhaar Verification'), findsOneWidget);
    expect(find.text('KYC Verification'), findsOneWidget);
    await tester.drag(find.byType(ListView), const Offset(0, -1200));
    await tester.pumpAndSettle();
    expect(find.text('Verify Aadhaar'), findsOneWidget);
  });

  testWidgets('Aadhaar screen smoke test', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      const MaterialApp(
        home: AadhaarVerificationScreen(),
      ),
    );

    expect(find.text('Step 2 of 2'), findsOneWidget);
    await tester.drag(find.byType(ListView), const Offset(0, -1400));
    await tester.pumpAndSettle();
    expect(find.text('256-bit SSL'), findsOneWidget);
    expect(find.text('Need Help?'), findsOneWidget);
  });

  testWidgets('Recruiter Verify Aadhaar opens producer dashboard', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      const MaterialApp(
        home: AadhaarVerificationScreen(isRecruiter: true),
      ),
    );
    await tester.drag(find.byType(ListView), const Offset(0, -1200));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Verify Aadhaar'));
    await tester.pumpAndSettle();

    expect(find.text('Sarah Johnson'), findsOneWidget);
    expect(find.text('Film Producer'), findsOneWidget);
    expect(find.text('Movie Projects'), findsOneWidget);
  });

  testWidgets('Producer dashboard smoke test', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      const MaterialApp(
        home: ProducerDashboardScreen(),
      ),
    );

    expect(find.text('Favorites'), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
  });

  testWidgets('Tapping project opens Project Details page', (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      const MaterialApp(
        home: ProducerDashboardScreen(),
      ),
    );

    await tester.tap(find.text('Spirit'));
    await tester.pumpAndSettle();

    expect(find.text('Project Details'), findsOneWidget);
    expect(find.text('Sprint Movie'), findsOneWidget);
    expect(find.text('Lead Actors'), findsOneWidget);
  });
}
