import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class Player {
  late int id;
  late String name;

  // Default constructor with optional parameters for empty initialization
  Player({required this.id, required this.name});

  // Named constructor for initializing with empty/default data
  Player.empty()
      : id = 0, // or -1, depending on your use case
        name = '';

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}


class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'acting_data.db');
    return openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE acting_players(id INTEGER PRIMARY KEY, name TEXT)',
    );
  }

  Future<void> insertPlayer(Player player) async {
    try {
      final db = await database;
      await db.insert('acting_players', player.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      print('Error inserting player: $e');
    }
  }

  Future<List<Player>> getPlayers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('acting_players');
    return List.generate(maps.length, (i) {
      return Player(
        id: maps[i]['id'],
        name: maps[i]['name'],
      );
    });
  }
}

Future<void> loadCsvData() async {
  final databaseHelper = DatabaseHelper();

  final ByteData data = await rootBundle.load('assets/acting_data.csv');
  final String rawData = String.fromCharCodes(data.buffer.asUint8List());

  List<List<dynamic>> csvData = CsvToListConverter().convert(rawData);

  for (int i = 1; i < csvData.length; i++) {
    Player player = Player(
      id: i,
      name: csvData[i][0],
    );

    // Check if player already exists
    List<Player> existingPlayers = await databaseHelper.getPlayers();
    final playerExists = existingPlayers.any((p) => p.id == player.id);

    if (!playerExists) {
      await databaseHelper.insertPlayer(player);
    }
  }
}
