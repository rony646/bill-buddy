import 'package:bill_buddy/utils/routes.dart';
import 'package:bill_buddy/widgets/custom_form_field.dart';
import 'package:bill_buddy/widgets/multiple_select.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateBill extends StatefulWidget {
  const CreateBill({super.key});

  @override
  State<CreateBill> createState() => _CreateBillState();
}

class _CreateBillState extends State<CreateBill> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateInputController = TextEditingController();
  List<int> _notifyOptions = [1];

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
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    String title = _titleController.text;
                    String date = _dateInputController.text;

                    print('Title: $title');
                    print('Date: $date');
                    print('Notify ops: $_notifyOptions');
                    // Navigator.of(context).pushNamed(Routes.home);
                  }
                },
                child: const Text('Submit'),
              )
            ],
          )),
    );
  }
}
