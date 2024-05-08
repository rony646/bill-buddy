import 'package:bill_buddy/utils/validate_email.dart';
import 'package:bill_buddy/widgets/custom_form_field.dart';
import 'package:flutter/material.dart';

import 'package:toggle_switch/toggle_switch.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

enum FormType { login, signUp }

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  FormType _selectedForm = FormType.login;

  @override
  Widget build(BuildContext context) {
    print(_selectedForm);
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
                    onToggle: (index) {
                      if (index == 0) {
                        setState(() {
                          _selectedForm = FormType.login;
                        });

                        return;
                      }

                      setState(() {
                        _selectedForm = FormType.signUp;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomFormField(
                          controller: _emailController,
                          hintText: 'Enter your e-mail...',
                        ),
                        CustomFormField(
                          controller: _passwordController,
                          hideText: true,
                          hintText: 'Enter your password...',
                        ),
                        if (_selectedForm == FormType.signUp)
                          CustomFormField(
                            controller: _confirmPasswordController,
                            hideText: true,
                            hintText: 'Confirm your password...',
                          ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            if (!isEmailValid(_emailController.text)) {
                              const snackBar = SnackBar(
                                backgroundColor:
                                    Color.fromARGB(210, 237, 64, 52),
                                content: Text(
                                  'Invalid e-mail address',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              return;
                            }
                            print('password: ${_passwordController.text}');
                          },
                          child: Text(_selectedForm == FormType.login
                              ? 'Login'
                              : 'Sign up'),
                        )
                      ],
                    ),
                  ),
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
