import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rae_test/bloc/rae/rae_bloc.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);
  @override
  @override
  Widget build(BuildContext context) {
    String _word = '';
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Form(
              key: _formKey,
              child: TextFormField(
                decoration: InputDecoration(contentPadding: EdgeInsets.all(8)),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onChanged: (value) {
                  _word = value;
                },
              )),
          Container(
              padding: EdgeInsets.all(24),
              child: Icon(
                Icons.error,
                color: Colors.red,
                size: 36,
              )),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            print(_word);
            context.bloc<RaeBloc>().add(RaeSubmit(word: _word));
          }
        },
        tooltip: 'Search',
        child: Icon(Icons.search),
      ),
    );
  }
}
