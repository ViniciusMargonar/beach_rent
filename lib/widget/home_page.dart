import 'package:beach_rent/banco/sqlite/dao_quadra.dart';
import 'package:beach_rent/dominio/dto/dto_quadra.dart';
import 'package:beach_rent/widget/login.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'form_cliente.dart';
import 'form_quadra.dart';
import 'lista_cliente.dart';
import 'lista_quadra.dart';
import 'package:beach_rent/banco/sqlite/conexao.dart'; // Certifique-se de importar a classe de conexão

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Map<String, double> dataMap;

  // Função para buscar quadras e atualizar o gráfico de pizza
  Future<void> fetchQuadras() async {
  // Buscar todas as quadras cadastradas
  var daoQuadra = DAOQuadra();
  List<DTOQuadra> quadras = await daoQuadra.listarTodos();

  // Contar a quantidade de quadras disponíveis e indisponíveis
  int disponiveis = quadras.where((quadra) => quadra.disponibilidade).length;
  int indisponiveis = quadras.length - disponiveis;

  // Atualizar os dados do gráfico de pizza
  setState(() {
    dataMap = {
      "Disponíveis": disponiveis.toDouble(),
      "Indisponíveis": indisponiveis.toDouble(),
    };
  });
}

  @override
  void initState() {
    super.initState();
    fetchQuadras(); // Carregar os dados das quadras ao iniciar
  }

  @override
  Widget build(BuildContext context) {
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
              // Exibir o gráfico de pizza com os dados atualizados
              dataMap == null
                  ? const CircularProgressIndicator() // Exibir um carregamento enquanto os dados não são carregados
                  : PieChart(
                      dataMap: dataMap,
                      chartType: ChartType.disc,
                      chartRadius: MediaQuery.of(context).size.width / 3,
                      colorList: const [
                        Color.fromARGB(255, 27, 254, 122),
                        Color.fromARGB(255, 255, 74, 74)
                      ],
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
                    padding: EdgeInsets.only(left: 16.0),
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
                    padding: EdgeInsets.only(left: 16.0),
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
                    padding: EdgeInsets.only(left: 16.0),
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
