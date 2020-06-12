import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lumberdash/lumberdash.dart';
import 'package:rae_test/bloc/rae/rae_bloc.dart';
import 'package:rae_test/pages/result_page.dart';
import 'package:rae_test/widgets/not_found_alert_widget.dart';
import 'package:rae_test/widgets/restore_fab_widget.dart';
import 'package:rae_test/widgets/search_fab_widget.dart';
import 'package:rae_test/widgets/title_widget.dart';
import 'package:rae_test/widgets/word_form.dart';
import 'package:rae_test/extension/context_extension.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

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
      if (state is RaeInitial) {
        _formKey.currentState?.reset();
      }
    }, builder: (context, state) {
      return Scaffold(
        floatingActionButton: state.searchFAB
            ? SearchFABWidget(formKey: _formKey)
            : RestoreFABWidget(
                formKey: _formKey,
              ),
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
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: context.pcw(12)),
                      child: WordForm(formKey: _formKey),
                    ),
                  ),
                  state.notFound
                      ? Expanded(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: context.pcw(2),
                                vertical: context.pcw(6)),
                            child: NotFoundAlertWidget(word: state.word),
                          ),
                        )
                      : Expanded(flex: 2, child: Container()),
                ],
              ),
            ),
            state is RaeLoading
                ? Center(child: CircularProgressIndicator())
                : Container(),
          ],
        )),
      );
    });
  }
}

