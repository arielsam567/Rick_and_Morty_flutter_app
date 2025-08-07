import 'package:flutter_test/flutter_test.dart';

void main() {
  group('String Utils Tests', () {
    test('should capitalize first letter correctly', () {
      // Arrange
      const input = 'hello world';
      const expected = 'Hello world';

      // Act
      final result = _capitalizeFirstLetter(input);

      // Assert
      expect(result, equals(expected));
    });

    test('should handle empty string', () {
      // Arrange
      const input = '';
      const expected = '';

      // Act
      final result = _capitalizeFirstLetter(input);

      // Assert
      expect(result, equals(expected));
    });

    test('should handle single character', () {
      // Arrange
      const input = 'a';
      const expected = 'A';

      // Act
      final result = _capitalizeFirstLetter(input);

      // Assert
      expect(result, equals(expected));
    });

    test('should handle already capitalized string', () {
      // Arrange
      const input = 'Hello World';
      const expected = 'Hello World';

      // Act
      final result = _capitalizeFirstLetter(input);

      // Assert
      expect(result, equals(expected));
    });

    test('should truncate long text correctly', () {
      // Arrange
      const input = 'This is a very long text that needs to be truncated';
      const maxLength = 20;
      const expected = 'This is a very lo...';

      // Act
      final result = _truncateText(input, maxLength);

      // Assert
      expect(result, equals(expected));
    });

    test('should not truncate short text', () {
      // Arrange
      const input = 'Short text';
      const maxLength = 20;
      const expected = 'Short text';

      // Act
      final result = _truncateText(input, maxLength);

      // Assert
      expect(result, equals(expected));
    });

    test('should handle empty text in truncation', () {
      // Arrange
      const input = '';
      const maxLength = 10;
      const expected = '';

      // Act
      final result = _truncateText(input, maxLength);

      // Assert
      expect(result, equals(expected));
    });

    test('should validate email format correctly', () {
      // Arrange
      const validEmail = 'test@example.com';
      const invalidEmail = 'invalid-email';

      // Act & Assert
      expect(_isValidEmail(validEmail), isTrue);
      expect(_isValidEmail(invalidEmail), isFalse);
    });

    test('should handle null email validation', () {
      // Arrange
      const nullEmail = null;

      // Act & Assert
      expect(_isValidEmail(nullEmail), isFalse);
    });

    test('should count words correctly', () {
      // Arrange
      const input = 'Hello world this is a test';
      const expected = 6;

      // Act
      final result = _countWords(input);

      // Assert
      expect(result, equals(expected));
    });

    test('should handle empty string word count', () {
      // Arrange
      const input = '';
      const expected = 0;

      // Act
      final result = _countWords(input);

      // Assert
      expect(result, equals(expected));
    });

    test('should handle string with multiple spaces', () {
      // Arrange
      const input = 'Hello   world    test';
      const expected = 3;

      // Act
      final result = _countWords(input);

      // Assert
      expect(result, equals(expected));
    });
  });
}

// Funções utilitárias para teste
String _capitalizeFirstLetter(String text) {
  if (text.isEmpty) return text;
  return text[0].toUpperCase() + text.substring(1);
}

String _truncateText(String text, int maxLength) {
  if (text.length <= maxLength) return text;
  return '${text.substring(0, maxLength - 3)}...';
}

bool _isValidEmail(String? email) {
  if (email == null || email.isEmpty) return false;
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  return emailRegex.hasMatch(email);
}

int _countWords(String text) {
  if (text.isEmpty) return 0;
  return text.trim().split(RegExp(r'\s+')).length;
}
