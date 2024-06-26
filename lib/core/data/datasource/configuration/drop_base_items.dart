import 'dart:convert';
import 'dart:developer';
import 'package:flutter/services.dart' show rootBundle;

import '../../models/drop_item_model.dart';

class DropBaseItems {

  List<DropItemModel> items=[];
  String nameItems='';

  void addItem(DropItemModel item) {
    items.add(item);
  }
  List<DropItemModel> getItems() {
    return items;
  }
  DropItemModel? getItem(String? origin) {
    return items.where((element) => element.origin==origin).firstOrNull;
  }
  Future<void> loadItemsFromFile(String filePath) async {
    try {

      String jsonString = await rootBundle.loadString(filePath);

      List jsonList = await json.decode(jsonString);

      items=jsonList.map((e) => DropItemModel.fromJson(e)).toList();

      log('تم تحميل قائمة $nameItems.');
    } catch (e) {
      log('حدث خطأ أثناء تحميل قائمة $nameItems: $e');
    }
  }
  Future<void> loadItems(List<DropItemModel> items) async {
    try {

      this.items=items;

      log('تم تحميل قائمة $nameItems.');
    } catch (e) {
      log('حدث خطأ أثناء تحميل قائمة $nameItems: $e');
    }
  }


}
