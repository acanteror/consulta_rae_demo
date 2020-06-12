import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rae_test/bloc/rae/rae_bloc.dart';

class RestoreFABWidget extends StatelessWidget {
  const RestoreFABWidget({
    Key key,
    @required GlobalKey<FormState> formKey,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        _formKey.currentState.reset();
        context.bloc<RaeBloc>().add(RaeRestore());
      },
      tooltip: 'Restaurar',
      child: Icon(Icons.restore),
    );
  }
}