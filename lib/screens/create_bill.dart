import 'package:bill_buddy/models/bill.dart';
import 'package:bill_buddy/providers/BillsProvider.dart';
import 'package:bill_buddy/utils/routes.dart';
import 'package:bill_buddy/widgets/custom_form_field.dart';
import 'package:bill_buddy/widgets/multiple_select.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

class CreateBill extends StatefulWidget {
  const CreateBill({super.key});

  @override
  State<CreateBill> createState() => _CreateBillState();
}

class _CreateBillState extends State<CreateBill> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateInputController = TextEditingController();
  final TextEditingController _valueInputController = TextEditingController();
  final TextEditingController _phoneNumberIputController =
      TextEditingController();
  List<int> _notifyOptions = [1];

  @override
  Widget build(BuildContext context) {
    return Consumer<BillsProvider>(
      builder: (context, billsProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Create a new bill'),
          ),
          body: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomFormField(
                    controller: _titleController,
                    hintText: 'Enter the bill title...',
                    validator: (value) {
                      if (value == '') {
                        return 'Enter a valid title';
                      }
                    },
                  ),
                  CustomFormField(
                    controller: _valueInputController,
                    hintText: 'Enter the bill value...',
                    inputFormatters: [CurrencyTextInputFormatter.currency()],
                  ),
                  CustomFormField(
                    controller: _dateInputController,
                    readOnly: true,
                    customDecoration: const InputDecoration(
                      icon: Icon(Icons.edit_calendar_outlined),
                      labelText: "Enter the bill due date...",
                    ),
                    validator: (value) {
                      if (value == '') {
                        return 'Enter a valid date';
                      }
                    },
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101),
                      );

                      if (pickedDate != null) {
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);

                        setState(() {
                          _dateInputController.text = formattedDate;
                        });
                      }
                    },
                  ),
                  MultipleSelect(
                    title: 'Where to notify?',
                    defaultOptions: _notifyOptions,
                    onSelect: (options) {
                      setState(() {
                        _notifyOptions = options;
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: IntlPhoneField(
                      decoration: const InputDecoration(
                        labelText: 'Your WhatsApp number',
                        border: OutlineInputBorder(),
                      ),
                      initialCountryCode: 'BR',
                      onChanged: (phone) {
                        setState(() {
                          _phoneNumberIputController.text =
                              phone.completeNumber;
                        });
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        String title = _titleController.text;
                        String date = _dateInputController.text;
                        String value = _valueInputController.text.replaceAll(
                          RegExp('USD'),
                          '',
                        );
                        String? phoneNumber = _phoneNumberIputController.text;
                        final uid = FirebaseAuth.instance.currentUser?.uid;

                        Bill newBill = Bill(
                          title: title,
                          dueDate: date,
                          value: value,
                          notificationChannels: _notifyOptions,
                          phoneToNotify: phoneNumber,
                        );

                        billsProvider.addBill(newBill, context, uid);

                        Navigator.of(context).pushNamed(
                          Routes.home,
                        );
                      }
                    },
                    child: const Text('Submit'),
                  )
                ],
              )),
        );
      },
    );
  }
}
