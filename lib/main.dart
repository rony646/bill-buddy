import 'package:bill_buddy/providers/BillsProvider.dart';
import 'package:bill_buddy/screens/create_bill.dart';
import 'package:bill_buddy/screens/home.dart';
import 'package:bill_buddy/screens/sign_up.dart';
import 'package:bill_buddy/themes/main_theme.dart';
import 'package:bill_buddy/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => BillsProvider())],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: mainTheme,
      initialRoute: Routes.sign_up,
      routes: {
        Routes.sign_up: (context) => const SignUp(),
        Routes.home: (context) => const Home(),
        Routes.create: (context) => const CreateBill(),
      },
    );
  }
}
