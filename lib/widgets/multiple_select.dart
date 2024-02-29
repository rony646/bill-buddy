import 'package:awesome_select/awesome_select.dart';
import 'package:flutter/material.dart';

class MultipleSelect extends StatelessWidget {
  MultipleSelect(
      {super.key,
      required this.title,
      required this.onSelect,
      required this.defaultOptions});

  final String title;
  final List<S2Choice<int>> options = [
    S2Choice<int>(value: 1, title: 'App Notification'),
    S2Choice<int>(value: 2, title: 'WhatsApp'),
    S2Choice<int>(value: 3, title: 'Telegram'),
  ];
  final Null Function(List<int>) onSelect;
  final List<int> defaultOptions;

  @override
  Widget build(BuildContext context) {
    return SmartSelect.multiple(
      title: title,
      selectedValue: defaultOptions,
      placeholder: 'Select your options',
      modalType: S2ModalType.bottomSheet,
      choiceItems: options,
      onChange: (state) {
        onSelect(state.value);
      },
    );
  }
}
