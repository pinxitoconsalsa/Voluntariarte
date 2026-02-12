import 'package:flutter/material.dart';

/// Colores de la aplicación siguiendo las especificaciones de diseño
/// Todos los colores cumplen con WCAG para accesibilidad
class AppColors {
  AppColors._();

  // Colores principales
  static const Color neonGreen = Color(0xFF13EC5B);
  static const Color darkGreen = Color(0xFF102216);
  static const Color lightGreen = Color(0xFFAFAFB0);
  static const Color white = Color(0xFFFFFFFF);
  
  // Colores de fondo
  static const Color background = darkGreen;
  static const Color cardBackground = Color(0xFF1A2F24);
  
  // Colores de texto
  static const Color textPrimary = white;
  static const Color textSecondary = lightGreen;
  
  // Colores de estado
  static const Color success = neonGreen;
  static const Color error = Color(0xFFFF4444);
  static const Color warning = Color(0xFFFFAA00);
  static const Color info = Color(0xFF00AAFF);
  
  // Colores de borde
  static const Color border = Color(0xFF2A3F34);
  static const Color borderFocus = neonGreen;
}
