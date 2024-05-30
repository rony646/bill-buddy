import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FireAuth {
  static Future<void> signUp({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      User? user;
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      user = userCredential.user;
      await user!.updateDisplayName(name);
      await user.reload();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password' && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).colorScheme.error,
            content: const Text('The entered password is too weak.'),
          ),
        );
      }

      if (e.code == 'email-already-in-use' && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).colorScheme.error,
            content: const Text('This e-mail is already in use.'),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).colorScheme.error,
            content: const Text('Something went wrong please try again later.'),
          ),
        );
      }
    }
  }

  static Future<void> signIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).colorScheme.error,
            content: const Text('This user was not found.'),
          ),
        );
      } else if (e.code == 'invalid-credential' && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).colorScheme.error,
            content: const Text('Wrong e-mail or password.'),
          ),
        );
      }
    }
  }

  static Future<void> signOut() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    await auth.signOut();
  }

  static bool checkIfUserIsLoggedIn() {
    FirebaseAuth auth = FirebaseAuth.instance;

    if (auth.currentUser != null) {
      return true;
    }

    return false;
  }
}
