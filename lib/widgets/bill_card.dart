import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BillCard extends StatelessWidget {
  final String title;
  final DateTime dueDate;
  final double billValue;

  const BillCard(this.title, this.dueDate, this.billValue, {super.key});

  String _getDaysToDueText() {
    final today = DateTime.now();
    final difference = dueDate.difference(today).inDays;

    if (difference == 0) {
      return 'This bill is due today!';
    }

    if (difference > 0 && difference <= 3) {
      return 'Due in $difference days';
    }

    return DateFormat('yyyy/MM/dd').format(dueDate);
  }

  @override
  Widget build(BuildContext context) {
    Color dueColor = const Color(0xFF2BC936);

    if (dueDate.difference(DateTime.now()).inDays == 0) {
      dueColor = const Color(0xFFF44336);
    }

    return Container(
      height: 140,
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Color(0xD6B7B7B7),
            blurRadius: 5,
            offset: Offset(0, 5),
          )
        ],
      ),
      child: Row(children: [
        SizedBox(
          height: 120,
          width: 11,
          child: DecoratedBox(
              decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            color: dueColor,
          )),
        ),
        Container(
          margin: const EdgeInsets.only(left: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF7C7C7C),
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
              Row(children: [
                Container(
                  margin: const EdgeInsets.only(right: 5),
                  child: const Icon(Icons.access_time_outlined),
                ),
                Text(
                  _getDaysToDueText(),
                  style: const TextStyle(fontSize: 16),
                )
              ]),
              Text(
                '\$${billValue.toStringAsFixed(2)}',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
