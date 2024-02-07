import 'package:flutter/material.dart';

class BillCard extends StatelessWidget {
  const BillCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 140,
      margin: const EdgeInsets.only(bottom: 20),
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
        Column(
          children: [
            const Text(
              'Credit card',
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
            Row(children: [
              Container(
                  margin: const EdgeInsets.only(right: 5),
                  child: const Icon(Icons.access_time_outlined)),
              const Text(
                'Due in: 25/06/2000',
                style: TextStyle(fontSize: 16),
              )
            ]),
            const Text(
              '\$150',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
            ),
          ],
        )
      ]),
    );
  }
}
