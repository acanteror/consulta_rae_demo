String validate(String value) {
  if (value.isEmpty) {
    return 'Debes introducir al menos una palabra';
  }

  if (moreThanOneWord(removeSpaces(value))) {
    return 'Debes introducir solo una palabra';
  }

  return null;
} 

bool moreThanOneWord(String words) {
  return words.split(' ').length > 1; 
}

String removeSpaces(String value) {
  return value.replaceAll(RegExp('[ ]{2,}'), ' ');
}
