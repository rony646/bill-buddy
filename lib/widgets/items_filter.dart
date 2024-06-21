import 'package:flutter/material.dart';

class ItemsFilter extends StatefulWidget {
  const ItemsFilter({super.key});

  @override
  State<ItemsFilter> createState() => _ItemsFilterState();
}

class _ItemsFilterState extends State<ItemsFilter> {
  bool orderByNewest = true;

  void handleFilterChange() {
    setState(() {
      orderByNewest = !orderByNewest;
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Your bills',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            )),
        // TextButton.icon(
        //   onPressed: handleFilterChange,
        //   icon: Icon(
        //       orderByNewest ? Icons.arrow_drop_down : Icons.arrow_drop_up,
        //       size: 24.0,
        //       color: const Color(0xC5363636)),
        //   label: Text(
        //     orderByNewest ? 'Newest' : 'Oldest',
        //     style: const TextStyle(
        //       color: Color(0xC5363636),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
