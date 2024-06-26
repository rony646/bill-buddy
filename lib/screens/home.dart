import 'package:bill_buddy/models/fire_auth.dart';
import 'package:bill_buddy/models/user_data.dart';
import 'package:bill_buddy/providers/BillsProvider.dart';
import 'package:bill_buddy/providers/UserDataProvider.dart';
import 'package:bill_buddy/utils/routes.dart';
import 'package:bill_buddy/widgets/bill_card.dart';
import 'package:bill_buddy/widgets/items_filter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void handleLogout(BuildContext context) {
    FireAuth.signOut();
    Navigator.of(context)
        .pushNamedAndRemoveUntil(Routes.sign_up, (route) => false);
  }

  @override
  void initState() {
    super.initState();
    final uid = FirebaseAuth.instance.currentUser?.uid;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<BillsProvider>(context, listen: false).getUserBills(uid);
    });
  }

  @override
  Widget build(BuildContext context) {
    final billsList = Provider.of<BillsProvider>(context).bills;
    // Provider.of<BillsProvider>(context).getUserBills();
    final User? user = FirebaseAuth.instance.currentUser;

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
              PopupMenuButton<Widget>(
                offset: const Offset(0, 45),
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).disabledColor,
                  child: Text(
                    '${user!.displayName?[0]}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                itemBuilder: (BuildContext context) => <PopupMenuEntry<Widget>>[
                  PopupMenuItem<Widget>(
                    child: TextButton(
                      onPressed: () => handleLogout(context),
                      child: Text(
                        'Exit',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.error),
                      ),
                    ),
                  ),
                ],
              ),
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
