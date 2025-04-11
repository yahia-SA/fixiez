import 'package:flutter/services.dart';

class AppStrings {
  static const String whatsAppNumber = '+201105817056';
}


class ArabicToEnglishNumberInputFormatter extends TextInputFormatter {
  static const Map<String, String> _arabicToEnglish = {
    '٠': '0',
    '١': '1',
    '٢': '2',
    '٣': '3',
    '٤': '4',
    '٥': '5',
    '٦': '6',
    '٧': '7',
    '٨': '8',
    '٩': '9',
  };

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String newText = newValue.text;
    
    // Convert Arabic numerals to English
    _arabicToEnglish.forEach((arabic, english) {
      newText = newText.replaceAll(arabic, english);
    });

    return TextEditingValue(
      text: newText,
      selection: newValue.selection,
    );
  }
}


String? validateEgyptianPhoneNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your phone number';
  }
  
  // Remove any non-digit characters
  final cleanedNumber = value.replaceAll(RegExp(r'[^\d]'), '');
  
  if (cleanedNumber.length != 11) {
    return 'Phone number must be 11 digits';
  }
  
  if (!RegExp(r'^01[0125][0-9]{8}$').hasMatch(cleanedNumber)) {
    return 'Enter a valid Egyptian phone number starting with 010, 011, 012, or 015';
  }
  
  return null;
}

String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a password';
  }

  // Check minimum length
  if (value.length < 8) {
    return 'Password must be at least 8 characters long';
  }

  // // Check for uppercase letters
  // if (!value.contains(RegExp(r'[A-Z]'))) {
  //   return 'Password must contain at least one uppercase letter';
  // }

  // // Check for lowercase letters
  // if (!value.contains(RegExp(r'[a-z]'))) {
  //   return 'Password must contain at least one lowercase letter';
  // }

  // // Check for numbers
  // if (!value.contains(RegExp(r'[0-9]'))) {
  //   return 'Password must contain at least one number';
  // }

  // // Check for special characters
  // if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
  //   return 'Password must contain at least one special character';
  // }

  // Check for whitespace
  if (value.contains(' ')) {
    return 'Password cannot contain spaces';
  }

  return null; // Return null if valid
}