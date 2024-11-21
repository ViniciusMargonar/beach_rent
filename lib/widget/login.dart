import 'package:beach_rent/widget/home_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Fundo branco
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Beach Rent!',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF025162), // Cor do título
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: const TextStyle(color: Color(0xFF025162)),
                  filled: true,
                  fillColor: const Color(0xFF5CE1E6), // Fundo do campo com azul claro
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  labelStyle: const TextStyle(color: Color(0xFF025162)),
                  filled: true,
                  fillColor: const Color(0xFF5CE1E6), // Fundo do campo com azul claro
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 24.0),
              SizedBox(
                width: double.infinity, // Define a largura igual à dos TextFields
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5CE1E6), // Azul claro para o botão
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    'Entrar',
                    style: TextStyle(
                      color: Color(0xFF025162), // Texto branco
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              GestureDetector(
                onTap: () {
                  // Navegação para tela de cadastro
                },
                child: const Text(
                  'Realizar Cadastro',
                  style: TextStyle(
                    color: Color(0xFF025162), // Texto azul escuro
                    fontSize: 14.0,
                    decoration: TextDecoration.underline, // Sublinhado
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
