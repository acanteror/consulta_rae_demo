import 'package:flutter/material.dart';
import 'package:rae_test/extension/context_extension.dart';

class NotFoundAlertWidget extends StatelessWidget {
  const NotFoundAlertWidget({
    Key? key,
    required String? word,
  }) : _word = word, super(key: key);

  final String? _word;

  @override
  Widget build(BuildContext context) {
    return Row(
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
            'La Rae no recoge la palabra \n"${_word!.toUpperCase()}"',
            maxLines: 2,
            style: TextStyle(
                fontSize: context.pcw(4),
                color: Colors.red),
          ),
        )
      ],
    );
  }
}