import 'package:flutter_test/flutter_test.dart';
import 'package:rae_test/helper/word_form_validation.dart';

void main() {
  group('word_form validation', () {
    test('removeSpaces reduce from one or more spaces to one between words',
        () {
      final beforeReducing = 'Test for   reducing     spaces';
      final afterReducing = 'Test for reducing spaces';
      final result = removeSpaces(beforeReducing);

      expect(result, afterReducing);
    });

    test('moreThanOneWord returns true if string contains more than one word',
        () {
      final str = 'Test for counting';
      final result = moreThanOneWord(str);

      expect(result, true);
    });

    test(
        'validate returns "Debes introducir al menos una palabra" if value is empty',
        () {
      final msg = 'Debes introducir al menos una palabra';
      final value = '';
      final result = validate(value);

      expect(result, msg);
    });

    test(
        'validate returns "Debes introducir solo una palabra" if value contains more than one word',
        () {
      final msg = 'Debes introducir solo una palabra';
      final value = 'uno dos tres';
      final result = validate(value);

      expect(result, msg);
    });

    test(
        'validate returns null if value contains just one word',
        () {
      final value = 'test';
      final result = validate(value);

      expect(result, null);
    });
  });
}
