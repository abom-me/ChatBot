import 'dart:io';

import 'package:arabic_font/arabic_font.dart';
import 'package:chatbot/welcome.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';

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
        fontFamily:
        ArabicThemeData.font(arabicFont: ArabicFont.dubai),
        package: ArabicThemeData.package,
        useMaterial3: true,
      ),
      home: WelcomeScreen(),
    );
  }
}
