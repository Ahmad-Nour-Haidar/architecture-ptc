import 'package:flutter/material.dart';
import '../../../../../core/utils/color_manager.dart';


class NavigationBarWidget extends StatelessWidget {
   NavigationBarWidget(
      {super.key,
      required this.icons,
       this.activeIndex=0, this.onTap,
      });

  final List<dynamic> icons;
   int activeIndex;
   final void Function(int)? onTap;

  @override
  Widget build(BuildContext context) {
    return
      Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          boxShadow: [
            BoxShadow(
              color: ColorManager.black.withOpacity(0.1),
              blurRadius: 20,
              spreadRadius: 2,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child:
        BottomAppBar(
            height:90,
          shape: const CircularNotchedRectangle(),
          notchMargin: 12,
          // color: Colors.blue,
          child: BottomNavigationBar(
            selectedItemColor:ColorManager.primary,
            currentIndex:activeIndex,
            backgroundColor:Colors.transparent,
            elevation:0,
            items:icons.map((e) =>
                BottomNavigationBarItem(icon: Icon(e),label: ''),
            ).toList(),
              onTap: (index) {
                 // activeIndex = index;
                onTap?.call(index);
              },
          ),

        ),
        // CurvedNavigationBar(
        //   color: ColorManager.textFieldColor.withOpacity(0.8),
        //   index:activeIndex,
        //   backgroundColor: Colors.transparent,
        //   buttonBackgroundColor: ColorManager.primary,
        //   items: [
        //     for(int i = 0; i < icons.length; i++) ...[
        //       Column(
        //         mainAxisAlignment: MainAxisAlignment.end,
        //         children: [
        //           CircleAvatar(
        //             radius:AppSize.s24,
        //             backgroundColor: Colors.transparent,
        //             child: IconHandler(icons[i],
        //               width: AppSize.s36,
        //               height: 70,
        //               color: activeIndex == i ? ColorManager.textFieldColor : ColorManager.grayDark.withOpacity(0.65),
        //
        //             ),
        //           ),
        //         ],
        //       ),
        //     ],
        //   ],
        //   onTap: (index) {
        //     // activeIndex = index;
        //     onTap?.call(index);
        //   },
        // ),
      )

     ;
  }
}
