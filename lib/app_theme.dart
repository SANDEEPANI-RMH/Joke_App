import 'package:flutter/material.dart';

class AppTheme {
  static const colorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF6366F1),      // Indigo primary
    onPrimary: Colors.white,
    secondary: Color(0xFFF1F5F9),    // Light gray
    onSecondary: Color(0xFF1E293B),  // Dark slate
    tertiary: Color(0xFF22D3EE),     // Cyan accent
    onTertiary: Colors.white,
    error: Color(0xFFDC2626),        // Red
    onError: Colors.white,
    background: Colors.white,
    onBackground: Color(0xFF1E293B),
    surface: Colors.white,
    onSurface: Color(0xFF1E293B),
    surfaceVariant: Color(0xFFF8FAFC),
    onSurfaceVariant: Color(0xFF1E293B),
    outline: Color(0xFF6366F1),
    shadow: Color(0xFF64748B),
  );

  static final cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.white,
      const Color(0xFFF1F5F9),
    ],
  );

  static List<BoxShadow> get cardShadow => [
    BoxShadow(
      color: const Color(0xFF6366F1).withOpacity(0.08),
      offset: const Offset(0, 4),
      blurRadius: 12,
    ),
    BoxShadow(
      color: const Color(0xFF6366F1).withOpacity(0.05),
      offset: const Offset(0, 8),
      blurRadius: 24,
    ),
  ];

  static BoxShadow get headerShadow => BoxShadow(
    color: const Color(0xFF6366F1).withOpacity(0.15),
    offset: const Offset(0, 4),
    blurRadius: 16,
  );

  static const animations = {
    'fast': Duration(milliseconds: 200),
    'normal': Duration(milliseconds: 300),
    'slow': Duration(milliseconds: 400),
  };

  static const spacing = {
    'xs': 4.0,
    'sm': 8.0,
    'md': 16.0,
    'lg': 24.0,
    'xl': 32.0,
  };

  static final borderRadius = {
    'sm': BorderRadius.circular(8),
    'md': BorderRadius.circular(12),
    'lg': BorderRadius.circular(16),
    'xl': BorderRadius.circular(24),
    'full': BorderRadius.circular(999),
  };
}