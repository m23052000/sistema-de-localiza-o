import 'package:hive/hive.dart';
import '../model/cep_model.dart';
import '../../http/cep_service.dart';

class CepRepository {
  final CepService _service = CepService();
  late Box _box;

  Future<void> init() async {
    _box = await Hive.openBox('cep');
  }

  Future<CepModel> buscarCep(String cep) async {
    final json = await _service.buscarCep(cep);
    final cepModel = CepModel.fromJson(json);
    await _box.put(cep, cepModel.toJson());
    return cepModel;
  }

  List<CepModel> buscarHistorico() {
    return _box.values.map((e) => CepModel.fromJson(Map<String, dynamic>.from(e))).toList();
  }
}
