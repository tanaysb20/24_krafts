import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/theme/krafts_design.dart';
import 'features/auth/presentation/screens/login_screen.dart';
import 'responsive.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: KraftsColors.primaryPurple,
        primary: KraftsColors.primaryPurple,
        surface: KraftsColors.white,
      ),
      scaffoldBackgroundColor: KraftsColors.white,
    );

    return MaterialApp(
      title: '24 Crafts',
      debugShowCheckedModeBanner: false,
      theme: base.copyWith(
        textTheme: GoogleFonts.interTextTheme(base.textTheme),
      ),
      builder: (context, child) {
        final width = MediaQuery.sizeOf(context).width;
        final maxWidth = width >= 1000 ? 560.0 : 760.0;
        return MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: TextScaler.linear(context.scale)),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: child ?? const SizedBox.shrink(),
            ),
          ),
        );
      },
      home: const LoginScreen(),
    );
  }
}
