import 'package:bill_buddy/widgets/auth_form.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

enum FormType { login, signUp }

class _SignUpState extends State<SignUp> {
  FormType _selectedForm = FormType.login;

  @override
  void initState() {
    super.initState();
  }

  void _handleChangeFormType(int? option) {
    if (option == 0) {
      setState(() {
        _selectedForm = FormType.login;
      });

      return;
    }

    setState(() {
      _selectedForm = FormType.signUp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 370,
          width: 370,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(top: 15.0),
                    child: Text(
                      'BillBuddy',
                      style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w500,
                          color: Color(0xE40E0E0E)),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: ToggleSwitch(
                    minWidth: 105,
                    fontSize: 15,
                    initialLabelIndex: _selectedForm == FormType.login ? 0 : 1,
                    totalSwitches: 2,
                    labels: const ['Login', 'Sign Up'],
                    icons: const [Icons.login, Icons.app_registration_outlined],
                    onToggle: (index) => _handleChangeFormType(index),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: AuthForm(selectedForm: _selectedForm),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
