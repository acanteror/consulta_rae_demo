import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lumberdash/lumberdash.dart';
import 'package:rae_test/bloc/rae/rae_bloc.dart';
import 'package:rae_test/pages/result_page.dart';
import 'package:rae_test/widgets/title_widget.dart';
import 'package:rae_test/extension/context_extension.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _word;
  bool _notFound;

  @override
  void initState() {
    super.initState();
    _word = '';
    _notFound = false;
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<RaeBloc, RaeState>(
          listener: (context, state) {
            if (state is RaeError) {
              //todo: show dialog
              logError('Error');
            }
            if (state is RaeSuccess) {
              setState(() {
                _word = '';
                _notFound = false;
              });
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ResultPage()),
              );
            }
            if (state is RaeNotFound) {
              _word = state.word;
            }
          },
          builder: (context, state) {
            _notFound = state is RaeNotFound;
            return Padding(
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
                      child: Form(
                          key: _formKey,
                          child: TextFormField(
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(context.pcw(2)),
                                hintText: '¿Qué palabra deseas buscar?',
                                hintStyle: TextStyle(fontSize: context.pcw(4))),
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Debes introducir al menos una palabra';
                              }

                              final _subValues =
                                  _removeSpaces(value).split(' ');
                              if (_subValues.length > 1) {
                                return 'Debes introducir solo una palabra';
                              }

                              return null;
                            },
                            onChanged: (value) {
                              _word = value;
                            },
                          )),
                    ),
                  ),
                  _notFound
                      ? Expanded(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: context.pcw(2),
                                vertical: context.pcw(6)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.error,
                                  color: Colors.red,
                                  size: context.pcw(10),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: context.pcw(5)),
                                  child: Text(
                                    'La Rae no recoge la palabra \n"${_word.toUpperCase()}"',
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: context.pcw(4),
                                        color: Colors.red),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      : Expanded(flex: 2, child: Container()),
                ],
              ),
            );
          },
        ),
      ),
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

  String _removeSpaces(String input) {
    return input.replaceAll(RegExp('/ */g '), ' ');
  }
}
