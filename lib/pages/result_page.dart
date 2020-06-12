import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rae_test/bloc/rae/rae_bloc.dart';
import 'package:rae_test/extension/context_extension.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _word = '';
    String _result = '';
    return BlocBuilder<RaeBloc, RaeState>(builder: (context, state) {
      if (state is RaeSuccess) {
        _word = state.word;
        _result = state.result;
      }
      return WillPopScope(
        onWillPop: () async {
          context.bloc<RaeBloc>().add(RaeRestore());
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(_word.toUpperCase()),
          ),
          body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.all(context.pcw(5)),
                alignment: Alignment.bottomLeft,
                child: Text(_result,
                    style: TextStyle(
                      fontSize: context.pcw(4),
                    ))),
          ),
        ),
      );
    });
  }
}
