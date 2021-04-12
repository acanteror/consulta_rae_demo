import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rae_test/bloc/rae_bloc.dart';
import 'package:rae_test/extension/context_extension.dart';
import 'package:rae_test/helper/word_form_validation.dart';

class WordFormWidget extends StatefulWidget {
  const WordFormWidget({
    Key? key,
    required GlobalKey<FormState> formKey,
  })   : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;

  @override
  _WordFormWidgetState createState() => _WordFormWidgetState();
}

class _WordFormWidgetState extends State<WordFormWidget> {
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
          final _validation = validate(value!);
          if (_validation != null) {
            context.read()<RaeBloc>().add(RaeValidationFails());
          }
          return _validation;
        },
        onSaved: (value) {
          context.read<RaeBloc>().add(RaeSubmit(word: value!));
        },
        onChanged: (v) {
          if (v.isEmpty) {
            context.read<RaeBloc>().add(RaeRestore());
          }
        },
      ),
    );
  }
}
