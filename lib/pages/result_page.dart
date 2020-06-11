import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rae_test/bloc/rae/rae_bloc.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _word = ''; 
    String _result = '';
    return BlocBuilder<RaeBloc, RaeState>(
      builder: (context, state) {
        if (state is RaeSuccess) {
          _word = state.word;
          _result = state.result;
        }
        return Scaffold(
            appBar: AppBar(
              title: Text(_word.toUpperCase()),
            ),
            body: SingleChildScrollView(
                          child: Container(
                  padding: EdgeInsets.all(18),
                  alignment: Alignment.bottomLeft,
                  child: Text(_result,
                      style: TextStyle(
                        fontSize: 18,
                      ))),
            ));
      }
    );
  }
}

