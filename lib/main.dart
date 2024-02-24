import 'package:bill_buddy/screens/create_bill.dart';
import 'package:bill_buddy/screens/home.dart';
import 'package:bill_buddy/themes/main_theme.dart';
import 'package:bill_buddy/utils/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: mainTheme,
      initialRoute: Routes.home,
      routes: {
        Routes.home: (context) => const Home(),
        Routes.create: (context) => const CreateBill(),
      },
    );
  }
}
