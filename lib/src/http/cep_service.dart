import 'package:dio/dio.dart';

class CepService {
  final Dio dio = Dio();

  Future<Map<String, dynamic>> buscarCep(String cep) async {
    try {
      final response = await dio.get('https://viacep.com.br/ws/$cep/json/');
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Erro ao buscar o CEP');
      }
    } catch (e) {
      throw Exception('Erro de conexão: $e');
    }
  }
}
