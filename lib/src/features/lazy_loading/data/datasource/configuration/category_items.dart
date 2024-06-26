import 'get_items.dart';

class CategoryItems {
  static final CategoryItems instance = CategoryItems._internal();

  CategoryItems._internal();

  List<String>? _item;
  Future<List<String>> get item async {
    _item ??= await _loadData();
    return _item!;
  }
  Future<List<String>> _loadData() async {

    return await getCategories();
  }
}