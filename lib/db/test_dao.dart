import 'package:flutter_mvvm_frame/db/database.dart';
import 'package:moor/moor.dart';

part 'test_dao.g.dart';
@UseDao(tables: [TestTable])
class TestDao extends DatabaseAccessor<TestDatabase> with _$TestDaoMixin{
  TestDao(TestDatabase attachedDatabase) : super(attachedDatabase);
  
}