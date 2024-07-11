import 'package:bill_buddy/models/user_data.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

UserData parseUserData(Map<String, dynamic> data) {
  final list = data.entries.map((entry) {
    final dynamic value = entry.value;
    return UserData(phoneNumber: value['phoneNumber'] ?? '');
  }).toList();

  return list[0];
}

class UserDataProvider with ChangeNotifier {
  UserData? _userData;

  UserData? get userData => UserData(phoneNumber: _userData?.phoneNumber);

  Future<void> getUserData(String? uid) async {
    if (uid != null) {
      DatabaseReference userDataRef =
          FirebaseDatabase.instance.ref('userData/$uid');
      final snapshot = await userDataRef.get();

      if (snapshot.exists) {
        final data = Map<String, dynamic>.from(snapshot.value as Map);
        final userData = parseUserData(data);

        _userData = userData;
        notifyListeners();
        return;
      }

      _userData = null;
      notifyListeners();
    }
  }
}
