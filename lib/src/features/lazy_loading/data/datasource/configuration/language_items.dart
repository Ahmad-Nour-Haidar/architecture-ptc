import 'get_items.dart';

class LanguagesItems {
  static final LanguagesItems instance = LanguagesItems._internal();

  LanguagesItems._internal();

  List<String>? _item;
  Future<List<String>> get item async {
    _item ??= await _loadData();
    return _item!;
  }
  Future<List<String>> _loadData() async {

    return await getLanguages();
  }
}