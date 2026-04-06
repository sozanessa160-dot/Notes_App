import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static Database? _db;
  Future<Database?> get db async {
    //كرمال اتاكد انو اذا انعكلا تهايئة او لا
    if (_db == null) {
      _db = await initialDb();
      return _db;
    } else {
      //التهيئة تعمل مرة واحدة فقط
      return _db;
    }
  }

  initialDb() async {
    String databasePath = await getDatabasesPath(); //جبنا مسار القاعدة
    String path = join(
      databasePath,
      'sozan.db',
    ); // يضع بينن سلاش بدمج المسار تبع لقاعدة مع اسم لقاعدة لاحصل  عالمسار
    Database mydb = await openDatabase(
      path,
      onCreate: _onCreate,
      version:
          4, //اذا بدي ضيف عمود او عدل شي لازم غير رقم الاصدار كرمال يستدعي الONUPGRADE
      onUpgrade: _onUpgrade,
    );
    return mydb;
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print('onUpgrade ========================================');
    await db.execute("ALTER TABLE notes ADD COLUMN color TEXT");
  }

  //انشاء الجدول
  _onCreate(Database db, int version) async {
    Batch batch = db.batch(); //بحال بدي ضيف اكتر من جدول بستخدم اباش
    batch.execute('''
     CREATE TABLE "notes"(
        "id" INTEGER PRIMARY KEY,
        "title" TEXT NOT NULL ,
        "note" TEXT NOT NULL ,
        "color" TEXT NOT NULL 
        )
''');
    batch.execute('''
     CREATE TABLE "students"(
        "id" INTEGER PRIMARY KEY,
        "title" TEXT NOT NULL ,
        "note" TEXT NOT NULL 
        )
''');
    await batch.commit(); //هي افضل من اني اعمل لكل جدول awaite db.execute
    //اسم العمود لا تسميه باسم الجدول
    print(
      "onCreate Database and Table ========================================",
    );
  }

  //select لارجاع قراءة الاسظر بالجدول
  readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(
      sql,
    ); //ضفنا! لانو ال rawqueryميثود وما فينا نستخدما مه تاnull
    return response;
  }

  // لاضافة سطر insert تعيد صفر بحال الفشل و تعيد رقم السطر بحال النجاح
  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  // لتحديث سطر
  updatetData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  // لاضافة سطر insert
  deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }

  mydeleteDatabase() async {
    String databasePath = await getDatabasesPath(); //جبنا مسار القاعدة
    String path = join(databasePath, 'sozan.db');
    await deleteDatabase(path);
  }

  //حذف لقاعدة
}
