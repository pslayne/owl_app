import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:owl_app/components/button.dart';
import 'package:owl_app/pages/entry_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0x00D6635D)),
        useMaterial3: true,
        textTheme: GoogleFonts.josefinSansTextTheme()
      ),
      home: EntryPage(),
    );
  }
}

