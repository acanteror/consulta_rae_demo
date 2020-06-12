import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lumberdash/lumberdash.dart';
import 'package:rae_test/bloc/rae/rae_bloc.dart';
import 'package:rae_test/pages/result_page.dart';
import 'package:rae_test/widgets/title_widget.dart';

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
              padding: const EdgeInsets.symmetric(vertical: 120.0),
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
                      padding: const EdgeInsets.symmetric(vertical: 48.0),
                      child: Form(
                          key: _formKey,
                          child: TextFormField(
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(8),
                                hintText: '¿Qué palabra deseas buscar?'),
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Debes introducir al menos una palabra';
                              }

                              final _subValues = _removeSpaces(value).split(' ');
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
                                horizontal: 8, vertical: 24),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.error,
                                  color: Colors.red,
                                  size: 36,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 14.0),
                                  child: Text(
                                    'La Rae no recoge la palabra \n"${_word.toUpperCase()}"',
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.red),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      : Expanded(flex: 2, child: Container()),
//              Container(child: Text('lalal')) //botón restore
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
