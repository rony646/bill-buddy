import 'package:flutter/material.dart';

class CreateBill extends StatelessWidget {
  const CreateBill({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create a new bill'),
      ),
      body: const Center(
        child: Text('Form aqui'),
      ),
    );
  }
}
