import 'package:flutter/material.dart';
import 'screens/loading_screen.dart';

void main() {
  runApp(Clima());
}

class Clima extends StatelessWidget {
  const Clima({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
          textTheme:
              ThemeData.dark().textTheme.apply(fontFamily: 'Montserrat')),
      home: LoadingScreen(),
    );
  }
}
