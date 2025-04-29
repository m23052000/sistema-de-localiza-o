import 'package:mobx/mobx.dart';
import '../model/cep_model.dart';
import '../repositories/cep_repository.dart';

part 'cep_controller.g.dart';

class CepController = _CepControllerBase with _$CepController;

abstract class _CepControllerBase with Store {
  final CepRepository _repository = CepRepository();

  _CepControllerBase() {
    _repository.init();
  }

  @observable
  ObservableFuture<CepModel?>? cepFuture;

  @observable
  String? errorMessage;

  @action
  Future<void> buscarCep(String cep) async {
    try {
      errorMessage = null;
      cepFuture = ObservableFuture(_repository.buscarCep(cep));
    } catch (e) {
      errorMessage = 'Erro ao buscar o CEP';
    }
  }
}
