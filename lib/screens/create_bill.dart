import 'dart:io';

import 'package:bill_buddy/models/bill.dart';
import 'package:bill_buddy/providers/BillsProvider.dart';
import 'package:bill_buddy/providers/UserDataProvider.dart';
import 'package:bill_buddy/utils/routes.dart';
import 'package:bill_buddy/widgets/custom_form_field.dart';
import 'package:bill_buddy/widgets/multiple_select.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:datepicker_dropdown/order_format.dart';
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
  final TextEditingController _phoneNumberInputController =
      TextEditingController();
  List<int> _notifyOptions = [1];
  String? phoneNumber;
  var _selectedMonth = 1;
  var _selectedDay = 1;

  void handleChangeDate(int? day, int? month) {
    if (day != null) {
      setState(() {
        _selectedDay = day;
      });
    }

    if (month != null) {
      _selectedMonth = month;
    }

    setState(() {
      var date = DateTime(
        DateTime.now().year,
        month ?? _selectedMonth,
        day ?? _selectedDay,
      );
      var formatedDate = DateFormat('yyyy-MM-dd').format(date);
      _dateInputController.text = formatedDate;
    });
  }

  @override
  void initState() {
    super.initState();
    final uid = FirebaseAuth.instance.currentUser?.uid;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<UserDataProvider>(context, listen: false).getUserData(uid);
    });
  }

  @override
  Widget build(BuildContext context) {
    final userPhoneNumber =
        Provider.of<UserDataProvider>(context).userData?.phoneNumber;

    if (userPhoneNumber != null) {
      setState(() {
        phoneNumber = userPhoneNumber;
      });
    } else {
      setState(() {
        phoneNumber = null;
      });
    }

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
                  Padding(
                    padding: const EdgeInsets.only(left: 9),
                    child: Column(
                      children: [
                        const SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Enter the bill due date...',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 14.3,
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(255, 96, 96, 96)),
                          ),
                        ),
                        DropdownDatePicker(
                          dateformatorder: OrderFormat.MDY,
                          showYear: false,
                          icon: const Icon(Icons.edit_calendar),
                          selectedDay: _selectedDay,
                          selectedMonth: _selectedMonth,
                          onChangedDay: (day) =>
                              handleChangeDate(int.parse(day as String), null),
                          onChangedMonth: (month) => handleChangeDate(
                              null, int.parse(month as String)),
                        ),
                      ],
                    ),
                  ),
                  // CustomFormField(
                  //   controller: _dateInputController,
                  //   readOnly: true,
                  //   customDecoration: const InputDecoration(
                  //     icon: Icon(Icons.edit_calendar_outlined),
                  //     labelText: "Enter the bill due date...",
                  //   ),
                  //   validator: (value) {
                  //     if (value == '') {
                  //       return 'Enter a valid date';
                  //     }
                  //   },
                  //   onTap: () async {
                  //     DateTime? pickedDate = await showDatePicker(
                  //       context: context,
                  //       initialDate: DateTime.now(),
                  //       firstDate: DateTime.now(),
                  //       lastDate: DateTime(DateTime.now().year).toLocal(),
                  //     );

                  //     if (pickedDate != null) {
                  //       String formattedDate =
                  //           DateFormat('yyyy-MM-dd').format(pickedDate);

                  //       setState(() {
                  //         _dateInputController.text = formattedDate;
                  //       });
                  //     }
                  //   },
                  // ),
                  MultipleSelect(
                    title: 'Where to notify?',
                    defaultOptions: _notifyOptions,
                    onSelect: (options) {
                      setState(() {
                        _notifyOptions = options;
                      });
                    },
                  ),
                  // if (phoneNumber == null)
                  //   Padding(
                  //     padding: const EdgeInsets.all(8),
                  //     child: IntlPhoneField(
                  //       decoration: const InputDecoration(
                  //         labelText: 'Your WhatsApp number',
                  //         border: OutlineInputBorder(),
                  //       ),
                  //       initialCountryCode: 'BR',
                  //       onChanged: (phone) {
                  //         setState(() {
                  //           _phoneNumberInputController.text =
                  //               phone.completeNumber;
                  //         });
                  //       },k
                  //     ),
                  //   ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        String title = _titleController.text;
                        String date = _dateInputController.text;
                        String? defaultDate;
                        String value = _valueInputController.text.replaceAll(
                          RegExp(r'[^0-9.]'), // Apenas números e ponto
                          '',
                        );
                        String? phoneNumber = _phoneNumberInputController.text;
                        final uid = FirebaseAuth.instance.currentUser?.uid;

                        print('data limpa: $date');
                        if (date == '') {
                          var date = DateTime(DateTime.now().year, 1, 1);
                          var formatedDate =
                              DateFormat('yyyy-MM-dd').format(date);
                          defaultDate = formatedDate;
                        }

                        Bill newBill = Bill(
                          title: title,
                          dueDate: defaultDate ?? date,
                          value: value,
                          notificationChannels: _notifyOptions,
                        );

                        billsProvider.addBill(
                            newBill, context, uid, phoneNumber);

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
