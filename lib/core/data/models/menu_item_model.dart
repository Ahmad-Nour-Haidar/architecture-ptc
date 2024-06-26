import 'package:flutter/cupertino.dart';

import '../enums/menu_item_enum.dart';

class MenuItem{
  dynamic  title;
  dynamic icon;
  String? route;
  VoidCallback? onTap;
  bool showDialog;
  Map<String,dynamic>? queryParameters;
  MenuItem({
    required this.title,
    this.icon,
    this.route,
    this.showDialog=false,
    this.onTap,
    this.queryParameters,
  }) : assert(title is String || title is MenuItemEnum, 'Title must be either String or MenuItemEnum'),
        assert(icon==null ||icon is IconData || icon is Widget, 'Icon must be either IconData or Widget');
}