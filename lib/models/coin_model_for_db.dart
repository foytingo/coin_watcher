

class CoinModelForDb {
  final int id;
  final String coinId;

  const CoinModelForDb({required this.id, required this.coinId});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'coinId': coinId
    };
  }

}