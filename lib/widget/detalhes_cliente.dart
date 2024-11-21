import 'package:flutter/material.dart';
import 'package:beach_rent/dominio/dto/dto_cliente.dart';

class DetalhesCliente extends StatelessWidget {
  final DTOCliente cliente;

  const DetalhesCliente({Key? key, required this.cliente}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes de ${cliente.nome}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nome: ${cliente.nome}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Email: ${cliente.email}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Telefone: ${cliente.telefone}', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
