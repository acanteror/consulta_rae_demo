import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lumberdash/lumberdash.dart';
import 'package:rae_test/bloc/rae/rae_bloc.dart';
import 'package:rae_test/pages/result_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _word;

  @override
  void initState() {
    super.initState();
    _word = '';
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
            final _showNotFoundIcon = state is RaeNotFound;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Form(
                    key: _formKey,
                    child: TextFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8),
                        hintText: '¿Qué palabras deseas buscar?'
                      ),
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
                _showNotFoundIcon
                    ? Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 14, vertical: 24),
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
                                'La Rae no recoge la palabra \n${_word.toUpperCase()}',
                                maxLines: 2,
                                style:
                                    TextStyle(fontSize: 16, color: Colors.red),
                              ),
                            )
                          ],
                        ),
                      )
                    : Container(),
//              Container(child: Text('lalal'))
              ],
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
}
