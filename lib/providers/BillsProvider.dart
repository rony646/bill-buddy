import 'package:bill_buddy/models/bill.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

List<Bill> parseBills(Map<String, dynamic> data) {
  return data.entries.map((entry) {
    final dynamic value = entry.value;
    return Bill(
      title: value['title'] ?? '',
      notificationChannels:
          (value['notificationChannels'] as List<dynamic>).cast<int>(),
      dueDate: value['dueDate'] ?? '',
      value: value['value'] ?? '',
    );
  }).toList();
}

class BillsProvider with ChangeNotifier {
  List<Bill> _bills = [];
  List<Bill> get bills => [..._bills];

  Future<void> getUserBills(String? uid) async {
    if (uid != null) {
      DatabaseReference billsRef = FirebaseDatabase.instance.ref('bills/$uid');
      final snapshot = await billsRef.get();

      if (snapshot.exists) {
        final data = Map<String, dynamic>.from(snapshot.value as Map);
        final list = parseBills(data);

        _bills = [...list];
        notifyListeners();
      }
    }
  }

  Future<void> addBill(
    Bill newBill,
    BuildContext context,
    String? uid,
    String? phoneNumber,
  ) async {
    _bills.add(newBill);

    if (uid != null) {
      try {
        DatabaseReference billsRef =
            FirebaseDatabase.instance.ref('bills/$uid').push();
        DatabaseReference userDataRef =
            FirebaseDatabase.instance.ref('userData/$uid').push();

        await billsRef.set({
          'title': newBill.title,
          'dueDate': newBill.dueDate,
          'value': newBill.value,
          'notificationChannels': newBill.notificationChannels,
        });
        await userDataRef.set({
          'phoneNumber': phoneNumber,
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
