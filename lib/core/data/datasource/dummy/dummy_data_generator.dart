import 'package:faker/faker.dart';

mixin class DummyDataGenerator<T> {
  T? generateDummyData() {}

  List<T>? generateDummyListData({int count = 3}) {
    return List.generate(count, (index) => generateDummyData()!);
  }
}
