
import '../../models/menu_item_model.dart';


class MenuItems{
  static final MenuItems _instance = MenuItems._internal();
  static MenuItems get instance => _instance;
  late List<MenuItem> _menuItems;

  factory MenuItems() {
    return _instance;
  }

  MenuItems._internal() {
    _menuItems = [];
  }

  void addMenuItem(MenuItem menuItem) {
    _menuItems.add(menuItem);
  }
  void addAllMenuItems(List<MenuItem> menuItems) {
    _menuItems.addAll(menuItems);
  }

  List<MenuItem> getAllMenuItems() {
    return _menuItems;
  }

  List<MenuItem> getSomeMenuItems(List<MenuItem> menuItems) {
    return menuItems.map((e) => getOneMenuItem(e)).where((e) => e != null).cast<MenuItem>().toList() ;
  }

  MenuItem? getOneMenuItem(MenuItem menuItem){
    MenuItem? resultMenuItem= _menuItems.where((element) => element.title == menuItem.title )
        .map((e) =>
                MenuItem(title: e.title,route: menuItem.route,onTap: menuItem.onTap,icon: menuItem.icon??e.icon,queryParameters: menuItem.queryParameters,showDialog:menuItem.showDialog )
          )
        .toList().firstOrNull;
    return resultMenuItem;
  }
}
