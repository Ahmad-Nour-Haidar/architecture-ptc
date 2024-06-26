import 'package:flutter/material.dart';
import '../../data/models/menu_item_model.dart';
import '../../utils/color_manager.dart';
import '../../utils/values_manager.dart';
import '../text/icon_with_text.dart';

class PopupMenuHelper {
  final BuildContext context;

  PopupMenuHelper(this.context);

  void showPopupMenu(Offset position,List<MenuItem> menuItems) {
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    if(menuItems.isNotEmpty) {

      showMenu(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      context: context,
      position: RelativeRect.fromRect(
        position & const Size(40, 40), // Size of the tap area
        Offset.zero & overlay.size,
      ),
      items: menuItems
          .map((menuItem) => PopupMenuItem(
        onTap: (menuItem.onTap!=null)?
        (!menuItem.showDialog )?
        menuItem.onTap
            :()=>  showDialog(
            context: context,
            builder: (context) {
              return const SizedBox.shrink();
                // AnswerDialog(title: formatText(menuItem.title), content: 'Are you sure ${formatText(menuItem.title)}?', yesButtonTap:menuItem.onTap);
            })
            :()=> menuItem.route==null?null:'',//goRouter.pushNamed(menuItem.route! ,extra: menuItem.queryParameters),
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconWithText(
              text: menuItem.title,
              icon: (menuItem.icon is IconData)?menuItem.icon:null,
              // textColor: ColorManager.primaryLight,
              textColor: ColorManager.primary,
              // iconColor: ColorManager.primaryLight,
              iconColor: ColorManager.primary,
              fontSize: AppSize.s12,
            ),
            const PopupMenuDivider(),
          ],
        ),
      ))
          .toList(),
    );
    }
  }
}