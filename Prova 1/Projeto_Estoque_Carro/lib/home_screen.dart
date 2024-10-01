import 'package:flutter/material.dart';
import 'carro_model.dart';
import 'carro_service.dart';
import 'add_edit_car_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Carro>> carros;
  List<Carro> carrosFiltrados = [];
  String searchQuery = '';
  final CarroService _carroService = CarroService();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    carros = _carroService.fetchCarros();
    _searchController.addListener(_onSearchChanged);
    _refreshCarros();
  }

  void _onSearchChanged() {
    setState(() {
      searchQuery = _searchController.text.toLowerCase();
      _filtrarCarros();
    });
  }

  void _filtrarCarros() {
    carros.then((listaCarros) {
      setState(() {
        carrosFiltrados = listaCarros
            .where((carro) => carro.modelo.toLowerCase().contains(searchQuery))
            .toList();
      });
    });
  }

  // Função para atualizar a lista de carros
  void _refreshCarros() {
    carros = _carroService.fetchCarros();
    carros.then((listaCarros) {
      setState(() {
        carrosFiltrados = listaCarros;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estoque de Carros'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Buscar por modelo',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Carro>>(
              future: carros,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Center(child: Text("${snapshot.error}"));
                } else {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.all(8.0),
                    itemCount: carrosFiltrados.length,
                    itemBuilder: (context, index) {
                      return _buildCarCard(carrosFiltrados[index]);
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToAddEditCarScreen();
        },
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildCarCard(Carro carro) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: SizedBox(
        width: 200,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.directions_car,
                size: 40,
                color: Colors.blueAccent,
              ),
              const SizedBox(height: 10),
              Text(
                '${carro.marca} ${carro.modelo}',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text('Ano: ${carro.ano}'),
              Text('Preço: R\$${carro.preco}'),
              const SizedBox(height: 5),
              Column(
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      _navigateToAddEditCarScreen(carro: carro);
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text("Editar"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize: const Size(100, 36),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    onPressed: () {
                      _carroService.deletarCarro(carro.id).then((_) {
                        _refreshCarros();
                      });
                    },
                    icon: const Icon(Icons.delete),
                    label: const Text("Excluir"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      minimumSize: const Size(100, 36),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToAddEditCarScreen({Carro? carro}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditCarScreen(carro: carro),
      ),
    );

    if (result == true) {
      _refreshCarros();
    }
  }
}
