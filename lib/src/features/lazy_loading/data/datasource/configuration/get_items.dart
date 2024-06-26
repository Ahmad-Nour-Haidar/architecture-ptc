import 'dart:convert';

import 'package:faker/src/faker.dart';
import 'package:flutter/services.dart';

getCategories() async {
  List<String> items=[];
  await Future.delayed( const Duration(seconds: 5), () {
    for(int i=0;i<1000;i++) {
      items.add(faker.lorem.words(3).join(' '));
    }});
  return items;
}


getVenues(){
  List<String> items=[];
  for(int i=0;i<1000;i++) {
    items.add(faker.lorem.words(2).join(' '));
  }
  return items;
}

getLanguages() async {
  List<String> items=[];
  String filePath="assets/lottie/languages.json";
  String jsonString = await rootBundle.loadString(filePath);

  List list = (await json.decode(jsonString))['items'];
  items=list.map((e) => e as String).toList();

  return items;
}