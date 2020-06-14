String validate(String value) {
  if (value.isEmpty) {
    return 'Debes introducir al menos una palabra';
  }

  if (moreThanOneWord(value)) {
    return 'Debes introducir solo una palabra';
  }

  return null;
}

bool moreThanOneWord(String value) {
  return removeSpaces(value).split(' ').length > 1; 
}

String removeSpaces(String value) {
  return value.replaceAll(RegExp('/ */g'), ' ');
}
