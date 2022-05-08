import 'package:farmer_app/core/models/farmer_data.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = "farmersdb.db";
  static const _databaseVersion = 1;

  static const table = 'farmers_tbl';

  static const columnId = 'id';
  static const fullName = 'fullName';
  static const gender = 'gender';
  static const address = 'address';
  static const plotArea = 'plotArea';
  static const crop = 'crop';
  static const variety = 'variety';
  static const plantingDate = 'plantingDate';
  static const ageOfCrop = 'ageOfCrop';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $fullName TEXT NOT NULL,
            $gender TEXT NOT NULL,
            $address TEXT NOT NULL,
            $plotArea DOUBLE NOT NULL,
            $crop TEXT NOT NULL,
            $variety TEXT NOT NULL,
            $plantingDate TEXT NOT NULL,
            $ageOfCrop INTEGER NOT NULL
          )
          ''');
  }

  Future<int> insertSudoData(List<FarmerData> farmers) async {
    Database db = await instance.database;
    for (FarmerData farmer in farmers) {
      await db.insert(table, {
        'fullName': farmer.fullName,
        'gender': farmer.gender,
        'address': farmer.address,
        'plotArea': farmer.plotArea,
        'crop': farmer.crop,
        'variety': farmer.variety,
        'plantingDate': farmer.plantingDate,
        'ageOfCrop': farmer.ageOfCrop,
      });
    }
    return 1;
  }

  Future<int> insert(FarmerData farmer) async {
    Database db = await instance.database;
    return await db.insert(table, {
      'fullName': farmer.fullName,
      'gender': farmer.gender,
      'address': farmer.address,
      'plotArea': farmer.plotArea,
      'crop': farmer.crop,
      'variety': farmer.variety,
      'plantingDate': farmer.plantingDate,
      'ageOfCrop': farmer.ageOfCrop,
    });
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<int> update(FarmerData farmer) async {
    Database db = await instance.database;
    int id = farmer.id!;
    return await db.update(table, farmer.toJson(),
        where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}
