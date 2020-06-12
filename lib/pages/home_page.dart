import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lumberdash/lumberdash.dart';
import 'package:rae_test/bloc/rae/rae_bloc.dart';
import 'package:rae_test/pages/result_page.dart';
import 'package:rae_test/widgets/not_found_alert_widget.dart';
import 'package:rae_test/widgets/title_widget.dart';
import 'package:rae_test/widgets/word_form.dart';
import 'package:rae_test/extension/context_extension.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String _word;
    bool _notFound;
    bool _searchFAB;

    print('here');

    return BlocConsumer<RaeBloc, RaeState>(listener: (context, state) {
      if (state is RaeError) {
        logError('Error');
      }
      if (state is RaeSuccess) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ResultPage()),
        );
      }
    }, builder: (context, state) {
      if (state is RaeNotFound) {
        _word = state.word;
        _searchFAB = state.searchFAB;
        _notFound = state.notFound;
      }
      if (state is RaeInitial) {
        _word = state.word;
        _searchFAB = state.searchFAB;
        _notFound = state.notFound;
        _formKey.currentState?.reset();
      }
      return Scaffold(
        floatingActionButton: _searchFAB
            ? _SearchFABWidget(formKey: _formKey)
            : _RestoreFABWidget(formKey: _formKey,),
        body: SafeArea(
            child: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: context.pcw(32)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: const TitleWidget(),
                  ),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: context.pcw(12)),
                      child: WordForm(formKey: _formKey),
                    ),
                  ),
                  _notFound
                      ? Expanded(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: context.pcw(2),
                                vertical: context.pcw(6)),
                            child: NotFoundAlertWidget(word: _word),
                          ),
                        )
                      : Expanded(flex: 2, child: Container()),
                ],
              ),
            ),
            Container(),
          ],
        )),
      );
    });
  }
}

class _RestoreFABWidget extends StatelessWidget {
  const _RestoreFABWidget({
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

class _SearchFABWidget extends StatelessWidget {
  const _SearchFABWidget({
    Key key,
    @required GlobalKey<FormState> formKey,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        if (_formKey.currentState.validate()) {
          _formKey.currentState.save();
        }
      },
      tooltip: 'Consultar',
      child: Icon(Icons.search),
    );
  }
}
