class PlayerBalance {
  PlayerBalance({required this.name, required this.balance});
  final String name;
  double balance;
}

class PlayerEntry {
  PlayerEntry({this.name = '', this.moneyIn = 0, this.moneyOut = 0});

  String name;
  double moneyIn;
  double moneyOut;
  double get net => moneyOut - moneyIn;

  Map<String, dynamic> toJSON() => {'name': name, 'moneyIn': moneyIn, 'moneyOut': moneyOut, 'net': net};
  PlayerEntry.fromJSON(Map<String, dynamic> j)
    : name = j['name'] ?? '',
      moneyIn = (j['moneyIn'] as num).toDouble(),
      moneyOut = (j['moneyOut'] as num).toDouble();

  PlayerEntry copy() => PlayerEntry(name: name, moneyIn: moneyIn, moneyOut: moneyOut);
}

class Transaction {
  Transaction({this.from = '', this.to = '', this.amount = 0});

  String from;
  String to;
  double amount;
}
