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
      print('chamou: $uid');
      DatabaseReference userDataRef =
          FirebaseDatabase.instance.ref('userData/$uid');
      final snapshot = await userDataRef.get();

      if (snapshot.exists) {
        final data = Map<String, dynamic>.from(snapshot.value as Map);
        print('data from provider: $data');
        final userData = parseUserData(data);

        _userData = userData;
        notifyListeners();
      }
    }
  }
}
