String? validateMobileNumber(String value) {
  // Check if the value is empty
  if (value.isEmpty) {
    return 'Enter mobile number';
  }

  // Check if the value contains only digits
  if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
    return 'Mobile number must contain only digits';
  }

  // Check if the value has exactly 10 digits
  if (value.length != 10) {
    return 'Mobile number must be exactly 10 digits';
  }

  // Check if the first digit is greater than 5
  if (int.parse(value[0]) < 6) {
    return 'First digit must be greater than 5';
  }

  return null;  // Return null if validation passes
}


String? validateEmail(String value) {
  if (value.isEmpty) {
    return 'Enter email';
  }
  final regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  if (!regex.hasMatch(value)) {
    return 'Please enter a valid email address';
  }
  return null;
}

String? validatePassword(String value) {
  if (value.isEmpty) {
    return 'Enter password';
  }
  if (value.length < 6) {
    return 'Password must be at least 6 characters';
  }
  return null;
}