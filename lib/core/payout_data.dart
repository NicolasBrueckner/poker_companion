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

class Preset {
  Preset({String? id, required this.names, required this.moneyIns})
    : id = id ?? DateTime.now().microsecondsSinceEpoch.toString();

  final String id;
  List<String> names;
  List<double> moneyIns;

  Map<String, dynamic> toJSON() => {'id': id, 'names': names, 'moneyIns': moneyIns};

  Preset.fromJSON(Map<String, dynamic> j)
    : id = j['id'] ?? DateTime.now().microsecondsSinceEpoch.toString(),
      names = List<String>.from(j['names']),
      moneyIns = (j['moneyIns'] as List).map((m) => (m as num).toDouble()).toList();
}
