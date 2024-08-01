import 'package:flutter/material.dart';
import 'barcode_scanner_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Barcode Scanner',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const BarcodeScannerScreen(),
    );
  }
}

class GoogleFonts {
  static poppinsTextTheme() {}
}
