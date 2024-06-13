import 'package:bill_buddy/models/bill.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class BillsProvider with ChangeNotifier {
  List<Bill> _bills = [];

  List<Bill> get bills => [..._bills];

  final User? _user = FirebaseAuth.instance.currentUser;

  Future<void> addBill(
    Bill newBill,
    BuildContext context,
  ) async {
    _bills.add(newBill);

    if (_user != null) {
      try {
        final uid = _user.uid;
        DatabaseReference billRef =
            FirebaseDatabase.instance.ref('bills/$uid').push();

        await billRef.set({
          'title': newBill.title,
          'dueDate': newBill.dueDate,
          'value': newBill.value,
          'notificationChannels': newBill.notificationChannels,
        });
      } catch (error) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Theme.of(context).colorScheme.error,
              content:
                  const Text('There was an error while creating your data.'),
            ),
          );
        }

        _bills.remove(newBill);
      }

      notifyListeners();
    }
  }
}
