import 'package:flutter/material.dart';

const lightColorScheme = ColorScheme(

brightness: Brightness.light,
primary: Color (0xFF3C9119),
onPrimary: Color (0xFFFFFFFF),
secondary: Color (0xFF91E66E),
onSecondary: Color (0xFFFFFFFF),
error: Color(0xFFBA1A1A),
onError: Color (0xFFFFFFFF),
background: Color(0xFFFCFDF6),
onBackground: Color (0xFF1A1C18),
shadow: Color (0xFF000000),
outlineVariant: Color (0xFFC2C8BC),
surface: Color (0xFFF9FAF3),
onSurface: Color (0xFF1A1C18),
); 

const darkColorScheme = ColorScheme (
brightness: Brightness.dark,
primary: Color (0xFF3C9119),
onPrimary: Color (0xFFFFFFFF),
secondary: Color (0xFF91E66E),
onSecondary: Color (0xFFFFFFFF),
error: Color (0xFFBA1A1A),
onError: Color(0xFFFFFFFF),
background: Color (0xFFFCFDF6),
onBackground: Color(0xFF1A1018),
shadow: Color(0xFF000000),
outlineVariant: Color(0xFFC2C8BC),
surface: Color (0xFFF9FAF3),
onSurface: Color (0xFF1A1C18),

); 

ThemeData lightMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: lightColorScheme, // Perbaiki LightColorScheme sesuai dengan konstanta yang Anda tentukan
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(
        // Tambahkan warna latar belakang yang diinginkan di sini
        const Color.fromARGB(255, 9, 141, 27), // Contoh: Warna biru
      ),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // text color
      elevation: MaterialStateProperty.all<double>(5.0), // shadow
      padding: MaterialStateProperty.all<EdgeInsets>(
        const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      ),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // Adjust as needed
        ), // RoundedRectangleBorder
      ),
    ), // ButtonStyle
  ), // ElevatedButtonThemeData
); // ThemeData
