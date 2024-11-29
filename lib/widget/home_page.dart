import 'package:beach_rent/widget/lista_cliente.dart';
import 'package:beach_rent/widget/login.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';  // Importando o pacote PieChart
import 'form_cliente.dart';
import 'form_quadra.dart';
import 'lista_quadra.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dados para o gráfico de pizza
    Map<String, double> dataMap = {
      "Disponíveis": 15,
      "Indisponíveis": 8,
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: const Color(0xFF5CE1E6),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Adicionando o PieChart acima dos botões
              PieChart(
                dataMap: dataMap,
                chartType: ChartType.disc,
                chartRadius: MediaQuery.of(context).size.width / 3,
                colorList: const [Color.fromARGB(255, 27, 254, 122), Color.fromARGB(255, 255, 74, 74)],
                chartValuesOptions: ChartValuesOptions(
                  showChartValues: true,
                  showChartValuesInPercentage: false,
                  showChartValuesOutside: false,
                  decimalPlaces: 1,
                  chartValueStyle: defaultChartValueStyle.copyWith(
                    color: Colors.black,
                  ),
                ),
                initialAngleInDegree: 0,
              ),
              const SizedBox(height: 32.0), // Espaçamento após o gráfico de pizza

              // Botão Lista de Clientes
              SizedBox(
                width: double.infinity, // Botões com largura total
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ListaCliente(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5CE1E6),
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  icon: const Padding(
                    padding: EdgeInsets.only(left: 16.0), // Ajuste o valor aqui
                    child: Icon(
                      Icons.people,
                      color: Color(0xFF025162),
                    ),
                  ),
                  label: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Lista de Clientes',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Color(0xFF025162),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16.0),

              // Botão Formulário de Cliente
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FormCliente(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5CE1E6),
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  icon: const Padding(
                    padding: EdgeInsets.only(left: 16.0), // Ajuste o valor aqui
                    child: Icon(
                      Icons.add_circle,
                      color: Color(0xFF025162),
                    ),
                  ),
                  label: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Formulário de Cliente',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Color(0xFF025162),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16.0),

              // Botão Lista de Quadras
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ListaQuadra(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5CE1E6),
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  icon: const Padding(
                    padding: EdgeInsets.only(left: 16.0), // Ajuste o valor aqui
                    child: Icon(
                      Icons.sports,
                      color: Color(0xFF025162),
                    ),
                  ),
                  label: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Lista de Quadras',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Color(0xFF025162),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16.0),

              // Botão Formulário de Quadra
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FormQuadra(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5CE1E6),
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  icon: const Padding(
                    padding: EdgeInsets.only(left: 16.0), // Ajuste o valor aqui
                    child: Icon(
                      Icons.add_circle,
                      color: Color(0xFF025162),
                    ),
                  ),
                  label: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Formulário de Quadra',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Color(0xFF025162),
                        ),
                      ),
                    ],
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
