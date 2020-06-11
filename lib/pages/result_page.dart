import 'package:flutter/material.dart';

class ReusltPage extends StatelessWidget {
  const ReusltPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('RESULT'));
  }
}

// Container(
//     padding: EdgeInsets.all(18),
//     child: Icon(
//       _result ? Icons.check : Icons.error,
//       color: _result ? Colors.green : Colors.red,
//       size: 36,
//     )),
// Container(
//     padding: EdgeInsets.all(18),
//     alignment: Alignment.bottomLeft,
//     child: Text(_data,
//         style: TextStyle(
//           fontSize: 18,
//         )))
