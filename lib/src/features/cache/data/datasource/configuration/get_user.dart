import 'dart:convert';

import 'package:faker/src/faker.dart';
import 'package:flutter/services.dart';

import '../../models/users.dart';

getUserById(int? id){
  if(id==null||id<0) return null;
  Map<String,dynamic> user={};
  user={
    "id":id,
    "first_name":faker.person.firstName(),
    "last_name":faker.person.lastName(),
    "about":faker.lorem.words(3).join(' '),
    "image":faker.image.image(),
  };
  return user;
}

getUsers() async {
  List<UserModel> items=[];
  String filePath="assets/lottie/users.json";
  String jsonString = await rootBundle.loadString(filePath);
  List list = (await json.decode(jsonString))['users'];

  items=list.map((e) => UserModel.fromJson(e)).toList();
  return items;
}