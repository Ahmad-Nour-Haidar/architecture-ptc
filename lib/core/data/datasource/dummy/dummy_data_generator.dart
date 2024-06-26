mixin class DummyDataGenerator<T> {
  T? generateDummyData() {
    return null;
  }

  List<T>? generateDummyListData({int count = 3}) {
    return List.generate(count, (index) => generateDummyData()!);
  }
}
