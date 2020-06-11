bool validateWord(String word, String result) {
  bool isValid = true;
  final error = 'Aviso: La palabra $word no está en el Diccionario.';
  if (result.startsWith(error)) isValid = false;
  print(isValid);
  return isValid;
}
