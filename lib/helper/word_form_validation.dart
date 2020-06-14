String validate(String value) {
  if (value.isEmpty) {
    return 'Debes introducir al menos una palabra';
  }

  if (_removeSpaces(value).split(' ').length > 1) {
    return 'Debes introducir solo una palabra';
  }

  return null;
}

String _removeSpaces(String input) {
  return input.replaceAll(RegExp('/ */g '), ' ');
}
