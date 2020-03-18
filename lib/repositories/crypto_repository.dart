import 'dart:convert';

import 'package:coin_app/models/coin_model.dart';
import 'package:coin_app/repositories/base_crypto_repository.dart';
import 'package:http/http.dart' as http;

class CryptoRepository extends BaseCryptoRepository {
  static const String _baseURL = 'https://min-api.cryptocompare.com';
  static const int _perPage = 20;

  final http.Client _httpClient;

  CryptoRepository({http.Client httpClient})
      // if no http.Client Pramater is passed in, than we want a new http.Client instance
      : _httpClient = httpClient ?? http.Client();

  @override
  Future<List<Coin>> getTopCoins({int page}) async {
    List<Coin> coins = [];
    String requestURL =
        '$_baseURL/data/top/totalvolfull?limit=$_perPage&tsym=USD&page=$page';
    try {
      final response = await _httpClient.get(requestURL);
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        List<dynamic> coinList = data['Data'];
        // iterate coinList and convert them to Coin model
        coinList.forEach(
          (json) => coins.add(Coin.fromJson(json)),
        );
      }
      return coins;
      
    } catch (err) {
      throw (err);
    }
  }

  @override
  void dispose() {
    _httpClient.close();
  }
}
