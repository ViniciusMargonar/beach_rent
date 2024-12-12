import 'package:beach_rent/banco/sqlite/dao_cliente.dart';
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
  late Map<String, double> dataMap = {};
  late int numeroClientes = 0;
  late double receitaEmReservas = 0.0; // Variável para armazenar a receita

  // Função para buscar quadras e atualizar o gráfico de pizza
  Future<void> fetchQuadras() async {
    var daoQuadra = DAOQuadra();
    List<DTOQuadra> quadras = await daoQuadra.listarTodos();

    int disponiveis = quadras.where((quadra) => quadra.disponibilidade).length;
    int indisponiveis = quadras.length - disponiveis;

    // Calcular a soma do preço por hora das quadras
    double totalPrecoPorHora = quadras.fold(0.0, (sum, quadra) => sum + quadra.precoPorHora);

    setState(() {
      dataMap = {
        "Disponíveis": disponiveis.toDouble(),
        "Indisponíveis": indisponiveis.toDouble(),
      };
      receitaEmReservas = totalPrecoPorHora; // Atualizar a receita
    });
  }

  // Função para buscar o número de clientes
  Future<void> fetchNumeroClientes() async {
    var daoCliente = DAOCliente();
    int clientes = await daoCliente.contarClientes();
    setState(() {
      numeroClientes = clientes;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchQuadras();
    fetchNumeroClientes();  // Carregar o número de clientes ao iniciar
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
        // Título acima do gráfico de pizza
        const Text(
          'Disponibilidade das Quadras',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF025162),
          ),
        ),
        const SizedBox(height: 16.0), // Espaçamento entre o título e o gráfico de pizza
        // Exibir o gráfico de pizza com os dados atualizados
        dataMap.isEmpty
            ? const CircularProgressIndicator()
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
              const SizedBox(height: 16.0), // Espaçamento após o gráfico de pizza
              // Exibir o número de clientes cadastrados
              ElevatedButton.icon(
                onPressed: () {}, // Não precisa de ação
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 92, 230, 156),
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
                label: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Clientes Cadastrados: $numeroClientes',
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Color(0xFF025162),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0), 
              // Exibir a receita em reservas
              ElevatedButton.icon(
                onPressed: () {}, // Não precisa de ação
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 92, 230, 156),
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                icon: const Padding(
                    padding: EdgeInsets.only(left: 16.0), // Ajuste o valor aqui
                    child: Icon(
                      Icons.attach_money,
                      color: Color(0xFF025162),
                    ),
                  ),
                label: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Receita em Reservas: \$${receitaEmReservas.toStringAsFixed(2)}', // Formatar para 2 casas decimais
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Color(0xFF025162),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0), 
              
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
