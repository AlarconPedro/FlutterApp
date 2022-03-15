import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _distanciaController = TextEditingController();
  final _valorGasController = TextEditingController();
  final _mediaConsumo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calcular Custo de Viagem'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      backgroundColor: Colors.green.shade200,
      body: ListView(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          _criarTexto(_distanciaController, 'Distância:', 'Km'),
          _criarTexto(_valorGasController, 'Valor do Combustível:', 'R\$'),
          _criarTexto(_mediaConsumo, 'Média do Veículo:', 'Km/l'),
          _criarBotao('Calcular', _calcularClique),
        ],
      ),
    );
  }

  Widget _criarTexto(
      TextEditingController controlador, String texto, String tipoEntrada) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 9.0, horizontal: 8.0),
      child: TextField(
        controller: controlador,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: texto,
          labelStyle: TextStyle(fontSize: 20),
          suffixText: tipoEntrada,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _criarBotao(String texto, VoidCallback clique) {
    return Padding(
      padding: EdgeInsets.only(left: 8.0, right: 8.0),
      child: ElevatedButton(
        onPressed: clique,
        child: Text(texto),
      ),
    );
  }

  void _calcularClique() {
    double distancia =
        double.tryParse(_distanciaController.text.replaceAll(',', '.')) ?? 0;
    double valorGas =
        double.tryParse(_valorGasController.text.replaceAll(',', '.')) ?? 0;
    double media =
        double.tryParse(_mediaConsumo.text.replaceAll(',', '.')) ?? 0;

    double resultado = (distancia / media) * valorGas;

    _mostrarMensagem('O Custo da viagem será de R\$ ${resultado}');
  }

  void _mostrarMensagem(String texto) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'Custo da Viagem',
              style: TextStyle(fontSize: 22),
            ),
            content: Text(
              texto,
              style: const TextStyle(fontSize: 20),
            ),
            actions: [
              _criarBotao('OK', () {
                Navigator.pop(context);
              }),
            ],
          );
        });
  }
}
