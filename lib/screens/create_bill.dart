import 'package:bill_buddy/widgets/custom_form_field.dart';
import 'package:flutter/material.dart';

class CreateBill extends StatefulWidget {
  const CreateBill({super.key});

  @override
  State<CreateBill> createState() => _CreateBillState();
}

class _CreateBillState extends State<CreateBill> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create a new bill'),
      ),
      body: Form(
          key: _formKey,
          child: Column(
            children: [
              // const CustomFormField(),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Submit'),
              )
            ],
          )),
    );
  }
}
