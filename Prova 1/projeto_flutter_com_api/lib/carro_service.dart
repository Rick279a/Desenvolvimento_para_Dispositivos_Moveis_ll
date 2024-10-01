import 'dart:convert';
import 'package:http/http.dart' as http;
import 'carro_model.dart';

class CarroService {
  final String baseUrl = 'http://127.0.0.1:8000/carros';

  Future<List<Carro>> fetchCarros() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((carro) => Carro.fromJson(carro)).toList();
    } else {
      throw Exception('Falha ao carregar os carros');
    }
  }

  Future<void> adicionarCarro(Carro carro) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(carro.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Falha ao adicionar o carro');
    }
  }

  Future<void> editarCarro(Carro carro) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${carro.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(carro.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Falha ao atualizar o carro');
    }
  }

  Future<void> deletarCarro(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Falha ao deletar o carro');
    }
  }

  Future<void> alterarDisponibilidade(int id, String status) async {
    final response = await http.patch(
      Uri.parse('http://127.0.0.1:8000/carros/$id/disponivel'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, String>{'status': status}),
    );
    if (response.statusCode != 200) {
      throw Exception('Falha ao alterar a disponibilidade do carro');
    }
  }
}
