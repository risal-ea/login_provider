import 'package:flutter/material.dart';
import 'package:login_provider/account_model.dart';
import 'package:login_provider/loginHome.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(
    ChangeNotifierProvider(create: (_) => Account(),
    child: MyApp(),)
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginHome(),
    );
  }
}
