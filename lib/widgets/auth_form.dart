import 'package:bill_buddy/models/fire_auth.dart';
import 'package:bill_buddy/screens/sign_up.dart';
import 'package:bill_buddy/utils/routes.dart';
import 'package:bill_buddy/utils/validate_email.dart';
import 'package:bill_buddy/widgets/custom_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final FormType selectedForm;
  const AuthForm({super.key, required this.selectedForm});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  bool _loading = false;

  _authenticateUser({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    setState(() {
      _loading = true;
    });

    if (widget.selectedForm == FormType.signUp) {
      await FireAuth.signUp(
        name: name,
        email: email,
        password: password,
        context: context,
      );
    }

    if (widget.selectedForm == FormType.login && context.mounted) {
      await FireAuth.signIn(
        email: email,
        password: password,
        context: context,
      );
    }

    if (context.mounted && FirebaseAuth.instance.currentUser?.uid != null) {
      Navigator.of(context).pushNamed(
        Routes.home,
      );
    }

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          if (widget.selectedForm == FormType.signUp)
            CustomFormField(
              controller: _userNameController,
              hintText: 'Enter your name...',
            ),
          CustomFormField(
            controller: _emailController,
            hintText: 'Enter your e-mail...',
          ),
          CustomFormField(
            controller: _passwordController,
            hideText: true,
            hintText: 'Enter your password...',
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              if (!isEmailValid(_emailController.text)) {
                const snackBar = SnackBar(
                  backgroundColor: Color.fromARGB(210, 237, 64, 52),
                  content: Text(
                    'Invalid e-mail address',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );

                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                return;
              }

              _authenticateUser(
                name: _userNameController.text,
                email: _emailController.text,
                password: _passwordController.text,
                context: context,
              );
            },
            child: _loading
                ? const SizedBox(
                    height: 25,
                    width: 25,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : Text(
                    widget.selectedForm == FormType.login ? 'Login' : 'Sign up',
                  ),
          )
        ],
      ),
    );
  }
}
