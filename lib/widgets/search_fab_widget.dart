import 'package:flutter/material.dart';

class SearchFABWidget extends StatelessWidget {
  const SearchFABWidget({
    Key? key,
    required GlobalKey<FormState> formKey,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
        }
      },
      tooltip: 'Consultar',
      child: Icon(Icons.search),
    );
  }
}