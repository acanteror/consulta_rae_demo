import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rae_test/bloc/rae/rae_bloc.dart';
import 'package:rae_test/extension/context_extension.dart';

class WordForm extends StatefulWidget {
  const WordForm({
    Key key,
    @required GlobalKey<FormState> formKey,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;

  @override
  _WordFormState createState() => _WordFormState();
}

class _WordFormState extends State<WordForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget._formKey,
        child: TextFormField(
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(context.pcw(2)),
                hintText: '¿Qué palabra deseas buscar?',
                hintStyle: TextStyle(fontSize: context.pcw(4))),
            keyboardType: TextInputType.text,
            validator: (value) {
              return _validate(value);
            },
            onSaved: (value) {
              context.bloc<RaeBloc>().add(RaeSubmit(word: value));
            }));
  }

  String _validate(String value) {
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
}
