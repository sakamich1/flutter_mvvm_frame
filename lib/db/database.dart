import 'dart:io';
import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';


class TestTable extends Table{
  // 主键
  IntColumn get id => integer().nullable().autoIncrement()();
} 

@UseMoor(tables: [TestTable])
class TestDatabase extends _$DateBase{
  TestDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
  
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file);
  });
}