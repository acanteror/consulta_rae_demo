import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Consulta RAE Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _word = '';
  bool _result = false;
  String _data = '';
  



  _search(String word) async {
    final url = 'https://dle.rae.es/$word';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final element = parse(response.body).getElementById('resultados');
      setState(() {
        _data = element.text;
      });
      return element.text;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return 'Http Error';
    }
  }

  bool _validateWord(String word, String result) {
    bool isValid = true;
    final error = 'Aviso: La palabra $word no está en el Diccionario.';
    if (result.startsWith(error)) isValid = false;
    print(isValid);
    return isValid;
  }

  static final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
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
              padding: EdgeInsets.all(18),
              child: Icon(_result ? Icons.check : Icons.error, color: _result ? Colors.green : Colors.red, size: 36,)),
            Container(
              padding: EdgeInsets.all(18),
              alignment: Alignment.bottomLeft,
              child: Text(_data, style: TextStyle(fontSize: 18,)))
          ],
        )),
        
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            final r = await _search(_word);
            setState(() {
              _result = _validateWord(_word, r);
            });
          }
        },
        tooltip: 'Search',
        child: Icon(Icons.search),
      ),
    );
  }
}
