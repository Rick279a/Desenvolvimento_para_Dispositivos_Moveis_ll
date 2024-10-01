import 'package:flutter/material.dart';
import 'carro_model.dart';
import 'carro_service.dart';

class AddEditCarScreen extends StatefulWidget {
  final Carro? carro;

  const AddEditCarScreen({super.key, this.carro});

  @override
  _AddEditCarScreenState createState() => _AddEditCarScreenState();
}

class _AddEditCarScreenState extends State<AddEditCarScreen> {
  final _formKey = GlobalKey<FormState>();
  final _marcaController = TextEditingController();
  final _modeloController = TextEditingController();
  final _anoController = TextEditingController();
  final _precoController = TextEditingController();
  final CarroService _carroService = CarroService();

  @override
  void initState() {
    super.initState();
    if (widget.carro != null) {
      _marcaController.text = widget.carro!.marca;
      _modeloController.text = widget.carro!.modelo;
      _anoController.text = widget.carro!.ano.toString();
      _precoController.text = widget.carro!.preco.toString();
    }
  }

  @override
  void dispose() {
    _marcaController.dispose();
    _modeloController.dispose();
    _anoController.dispose();
    _precoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.carro == null ? 'Adicionar Carro' : 'Editar Carro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _marcaController,
                decoration: const InputDecoration(labelText: 'Marca'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a marca';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _modeloController,
                decoration: const InputDecoration(labelText: 'Modelo'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o modelo';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _anoController,
                decoration: const InputDecoration(labelText: 'Ano'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o ano';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _precoController,
                decoration: const InputDecoration(labelText: 'Preço'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o preço';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final novoCarro = Carro(
                      id: widget.carro?.id ??
                          DateTime.now().millisecondsSinceEpoch,
                      marca: _marcaController.text,
                      modelo: _modeloController.text,
                      ano: int.parse(_anoController.text),
                      preco: double.parse(_precoController.text),
                      status: widget.carro?.status ?? 'Disponível',
                    );

                    if (widget.carro == null) {
                      // Adicionar novo carro
                      _carroService.adicionarCarro(novoCarro).then((_) {
                        Navigator.of(context).pop(true);
                      });
                    } else {
                      // Editar carro existente
                      _carroService.editarCarro(novoCarro).then((_) {
                        Navigator.of(context).pop(true);
                      });
                    }
                  }
                },
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
