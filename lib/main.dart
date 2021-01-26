import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'bar/bar.dart';
import 'body/body.dart';
import 'provider/provider.dart';

void main() => runApp(Root());

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => InitProviders(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: BarState(),
          body: SingleChildScrollView(
            child: BodyState(),
          ),
        ),
      ),
    );
  }
}
