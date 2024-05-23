import 'package:bill_buddy/providers/BillsProvider.dart';
import 'package:bill_buddy/utils/routes.dart';
import 'package:bill_buddy/widgets/bill_card.dart';
import 'package:bill_buddy/widgets/items_filter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final billsList = Provider.of<BillsProvider>(context).bills;

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 231, 231, 231),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, Routes.create);
          },
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: const Color(0xFFFFFFFF),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(50),
            ),
          ),
          child: const Icon(Icons.add, size: 35),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
                children: billsList
                    .map(
                      (bill) => BillCard(
                        bill.title,
                        DateTime.parse(bill.dueDate),
                        bill.value,
                      ),
                    )
                    .toList(),
              )
            ],
          ),
        ));
  }
}
