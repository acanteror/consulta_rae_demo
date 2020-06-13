import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lumberdash/lumberdash.dart';
import 'package:colorize_lumberdash/colorize_lumberdash.dart';
import 'package:rae_test/bloc/rae_bloc.dart';
import 'package:rae_test/debug/simple_bloc_delegate.dart';
import 'package:rae_test/di/inyector.dart';
import 'pages/home_page.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  putLumberdashToWork(withClients: [ColorizeLumberdash()]);
  configureInyector();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RaeBloc(),
      child: GetMaterialApp(
        title: 'Consulta RAE Demo',
        theme: ThemeData(
          primarySwatch: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage(),
      ),
    );
  }
}
