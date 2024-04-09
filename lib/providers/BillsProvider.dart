import 'package:bill_buddy/models/bill.dart';
import 'package:flutter/material.dart';

class BillsProvider with ChangeNotifier {
  List<Bill> _bills = [];

  List<Bill> get bills => [..._bills];

  void addBill(Bill newBill) {
    _bills.add(newBill);

    notifyListeners();
  }
}
