

import 'package:architecture_ptc/core/data/datasource/configuration/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../src/features/core/presentation/cubits/file_manager_cubit/file_manager_cubit.dart';
import '../../../../src/features/core/presentation/cubits/splash_cubit/splash_cubit.dart';
import '../../../../src/features/core/presentation/cubits/user_cubit/user_cubit.dart';
import '../../../../src/features/mail_box/presentation/cubits/recicve_request_box_cubit/recive_request_box_cubit.dart';
import '../../../../src/features/mail_box/presentation/cubits/replay_box_cubit/replay_box_cubit.dart';
import '../../../../src/features/mail_box/presentation/cubits/request_box_cubit/request_box_cubit.dart';
import '../../enums/menu_item_enum.dart';
import '../../models/drop_item_model.dart';
import '../../models/menu_item_model.dart';
import 'drop_languages.dart';
import 'menu_items.dart';

initDataConfiguration() async {
  _initMenuItems();
  _initDropLanguages();

}


 initProviders(){

  return [
    BlocProvider<SplashCubit>(create: (context) => SplashCubit(),),
    BlocProvider<UserCubit>(create: (context) => UserCubit(authRepository)),
    BlocProvider<ReciveRequestBoxCubit>(create: (context) => ReciveRequestBoxCubit(requestBoxRepository)),
    BlocProvider<ReplayBoxCubit>(create: (context) => ReplayBoxCubit(replayBoxRepository)),
    BlocProvider<RequestBoxCubit>(create: (context) => RequestBoxCubit(requestBoxRepository)),
    BlocProvider<FileManagerCubit>(
      create: (context) =>   FileManagerCubit(
      ),
    ),
  ];
}

_initMenuItems() async {
  MenuItems menuItems=MenuItems.instance;
  menuItems.addAllMenuItems([
    MenuItem(title: MenuItemEnum.add,icon: Icons.add_circle_outline),
    MenuItem(title: MenuItemEnum.details,icon: Icons.info_outline),
    MenuItem(title: MenuItemEnum.duplicate,icon: Icons.copy_outlined),
    MenuItem(title: MenuItemEnum.edit,icon: Icons.edit_outlined),
    MenuItem(title: MenuItemEnum.delete,icon: Icons.delete_outline),
    MenuItem(title: MenuItemEnum.active,icon: Icons.check_circle_outline),
    MenuItem(title: MenuItemEnum.deactivate,icon: Icons.remove_circle_outline),
    MenuItem(title: MenuItemEnum.pay,icon: Icons.payment_outlined),
    MenuItem(title: MenuItemEnum.kicked,icon: Icons.output_outlined),
    MenuItem(title: MenuItemEnum.undo,icon: Icons.undo_outlined),
  ]);
}
_initDropLanguages() async {
  DropLanguages dropLanguages=DropLanguages.instance;
  // await dropLanguages.loadItemsFromFile( AssetsManager.dropLanguagesJson);
  await dropLanguages.loadItems([
    DropItemModel(name:"en",origin: "en",//image: AssetsManager.ukIcon
    ),
    DropItemModel(name:"ar",origin: "ar",//image: AssetsManager.arIcon
    ),
  ]);
}
