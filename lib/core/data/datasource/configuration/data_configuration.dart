import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../src/features/core/presentation/cubits/file_manager_cubit/file_manager_cubit.dart';
import '../../../../src/features/core/presentation/cubits/splash_cubit/splash_cubit.dart';
import '../../../../src/features/core/presentation/cubits/user_cubit/user_cubit.dart';
import '../../../../src/features/mail_box/presentation/cubits/request_box_cubit/request_box_cubit.dart';
import '../../enums/menu_item_enum.dart';
import '../../models/menu_item_model.dart';

import 'locator.dart';
import 'menu_items.dart';

initDataConfiguration() async {
  _initMenuItems();
}

initProviders() {
  return [
    BlocProvider<SplashCubit>(create: (context) => locator<SplashCubit>()),
    BlocProvider<UserCubit>(create: (context) => locator<UserCubit>()),
    BlocProvider<RequestBoxCubit>(
        create: (context) => locator<RequestBoxCubit>()),
    BlocProvider<FileManagerCubit>(
        create: (context) => locator<FileManagerCubit>()),
  ];
}

_initMenuItems() async {
  MenuItems menuItems = MenuItems.instance;
  menuItems.addAllMenuItems([
    MenuItem(title: MenuItemEnum.add, icon: Icons.add_circle_outline),
    MenuItem(title: MenuItemEnum.details, icon: Icons.info_outline),
    MenuItem(title: MenuItemEnum.duplicate, icon: Icons.copy_outlined),
    MenuItem(title: MenuItemEnum.edit, icon: Icons.edit_outlined),
    MenuItem(title: MenuItemEnum.delete, icon: Icons.delete_outline),
    MenuItem(title: MenuItemEnum.active, icon: Icons.check_circle_outline),
    MenuItem(title: MenuItemEnum.deactivate, icon: Icons.remove_circle_outline),
    MenuItem(title: MenuItemEnum.pay, icon: Icons.payment_outlined),
    MenuItem(title: MenuItemEnum.kicked, icon: Icons.output_outlined),
    MenuItem(title: MenuItemEnum.undo, icon: Icons.undo_outlined),
  ]);
}
