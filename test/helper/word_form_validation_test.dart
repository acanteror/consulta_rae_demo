import 'package:flutter_test/flutter_test.dart';
import 'package:rae_test/helper/word_form_validation.dart';

void main() {
  group('word_form validation', () {
    test('removeSpaces reduce to one space if between words there are more than one space', () {
      final beforeReducing = 'Test for   reducing     spaces';
      final afterReducing = 'Test for reducing spaces';
      //final result = removeSpaces(beforeReducing);
      final result = beforeReducing.replaceAll(RegExp('/ */g'), ' ');

      expect(result, afterReducing);
    });

  });
}