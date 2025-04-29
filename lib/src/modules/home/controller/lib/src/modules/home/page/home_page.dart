import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../controller/cep_controller.dart';
import '../model/cep_model.dart';

class HomePage extends StatelessWidget {
  final CepController controller = CepController();
  final TextEditingController cepController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consulta de CEP'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: cepController,
              decoration: InputDecoration(
                labelText: 'Digite o CEP',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.buscarCep(cepController.text);
              },
              child: Text('Buscar'),
            ),
            SizedBox(height: 20),
            Observer(
              builder: (_) {
                if (controller.cepFuture == null) {
                  return Container();
                }

                switch (controller.cepFuture!.status) {
                  case FutureStatus.pending:
                    return CircularProgressIndicator();
                  case FutureStatus.rejected:
                    return Text('Erro: ${controller.errorMessage}');
                  case FutureStatus.fulfilled:
                    final CepModel? cep = controller.cepFuture!.result;
                    return cep != null ? buildCepInfo(cep) : Text('CEP não encontrado.');
                  default:
                    return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCepInfo(CepModel cep) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('CEP: ${cep.cep}'),
        Text('Logradouro: ${cep.logradouro}'),
        Text('Bairro: ${cep.bairro}'),
        Text('Localidade: ${cep.localidade}'),
        Text('UF: ${cep.uf}'),
      ],
    );
  }
}
