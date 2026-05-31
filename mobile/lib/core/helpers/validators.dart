import 'dart:core';

class KValidators {
  // Name Validator
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }

    // Check if name contains only letters, spaces, hyphens, and apostrophes
    final nameRegex = RegExp(r"^[a-zA-Z]+(?:[' -][a-zA-Z]+)*$");

    if (!nameRegex.hasMatch(value)) {
      return 'Please enter a valid name (letters, spaces, hyphens, or apostrophes only)';
    }

    // Check minimum length
    if (value.length < 2) {
      return 'Name must be at least 2 characters';
    }

    // Check maximum length (reasonable limit)
    if (value.length > 50) {
      return 'Name must be less than 50 characters';
    }

    return null;
  }

  // Email Validator
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  // Nigerian Phone Number Validator
  static String? validateNigerianPhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }

    // Remove all non-digit characters
    final digitsOnly = value.replaceAll(RegExp(r'[^\d]'), '');

    // Check if it's a valid Nigerian number
    // Nigerian numbers: 10-11 digits, starting with 0, 234, or +234
    final validPatterns = [
      RegExp(r'^0[7-9][0-1]\d{8}$'), // 0803xxxxxxx, 0701xxxxxxx, 0905xxxxxxx
      RegExp(r'^234[7-9][0-1]\d{8}$'), // 234803xxxxxxx, 234701xxxxxxx
      RegExp(r'^\+234[7-9][0-1]\d{8}$'), // +234803xxxxxxx
    ];

    bool isValid = validPatterns.any((pattern) => pattern.hasMatch(digitsOnly));

    if (!isValid) {
      return 'Please enter a valid Nigerian phone number (e.g., 08031234567, 2348031234567)';
    }

    return null;
  }

  // Password Validator: 6 min, 14 max, any symbols allowed
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    // Check minimum length
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }

    // Check maximum length
    if (value.length > 14) {
      return 'Password must be no more than 14 characters';
    }

    // Check for at least one uppercase letter
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }

    // Check for at least one lowercase letter
    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }

    // Check for at least one number
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }

    // Check for at least one symbol
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one symbol';
    }

    return null;
  }

  static String? validateSixDigitPin(String? value) {
    if (value == null || value.isEmpty) {
      return 'PIN is required';
    }

    // Must be exactly 6 digits
    final pinRegex = RegExp(r'^\d{6}$');

    if (!pinRegex.hasMatch(value)) {
      return 'PIN must be exactly 6 digits';
    }

    return null;
  }

  static String? validateBvn(String? value) {
    if (value == null || value.isEmpty) {
      return 'BVN is required';
    }

    // Remove spaces just in case
    final cleanedValue = value.replaceAll(RegExp(r'\s+'), '');

    // Must be exactly 11 digits
    final bvnRegex = RegExp(r'^\d{11}$');

    if (!bvnRegex.hasMatch(cleanedValue)) {
      return 'BVN must be exactly 11 digits';
    }

    return null;
  }

  // Residential Address Validator
  static String? validateAddress(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Residential address is required';
    }

    if (value.trim().length < 10) {
      return 'Please enter a complete address';
    }

    if (value.trim().length > 120) {
      return 'Address is too long';
    }

    return null;
  }
}
