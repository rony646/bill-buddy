import 'package:bill_buddy/widgets/bill_card.dart';
import 'package:bill_buddy/widgets/items_filter.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 231, 231, 231),
        appBar: AppBar(
          toolbarHeight: 100,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment(0, 0.9),
                colors: [
                  Color(0xFF3078E3),
                  Color(0xFF3E89FA),
                ],
              ),
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            child: Row(children: [
              const Expanded(
                  child: Text(
                'BillBuddy',
                style: TextStyle(fontSize: 25),
              )),
              CircleAvatar(
                backgroundColor: Theme.of(context).disabledColor,
                child: const Text('RP', style: TextStyle(fontSize: 16)),
              )
            ]),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const ItemsFilter(),
              Column(
                children: [
                  BillCard('Conta de luz', DateTime(2024, 2, 19)),
                  BillCard('Curso', DateTime(2024, 2, 25)),
                  BillCard('Mercado', DateTime.now())
                ],
              )
            ],
          ),
        ));
  }
}
