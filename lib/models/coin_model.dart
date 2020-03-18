import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Coin extends Equatable {
  final String name;
  final String fullname;
  final double price;

  Coin({@required this.name, @required this.fullname, @required this.price});

  @override
  List<Object> get props => [
        name,
        fullname,
        price,
      ];

  @override
  String toString() => 'Coin {name: $name, fullname: $fullname, price: $price';

  factory Coin.fromJson(Map<String, dynamic> json) {
    return Coin(
      name: json['CoinInfo']['Name'] as String,
      fullname: json['CoinInfo']['FullName'] as String,
      price: (json['RAW']['USD']['PRICE'] as num).toDouble(),
    );
  }
}
