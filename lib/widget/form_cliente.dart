import 'package:flutter/material.dart';

class FormCliente extends StatelessWidget{
  const FormCliente({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextButton(
            onPressed: () => Navigator.pop(context), 
            child: const Text('Lista Professor'))
        ],
      )
    );
  }
}