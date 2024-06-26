import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../utils/color_manager.dart';
import '../utils/values_manager.dart';

class ToastWidget extends StatelessWidget {
  const ToastWidget(
      {super.key,
      this.title = 'Title',
      this.icon ,
      this.description = 'Description',
      this.color = ColorManager.warning});

  final String title;
  final IconData? icon;
  final String description;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.all(AppMargin.m12),
                padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p12, vertical: AppPadding.p6),
                decoration: BoxDecoration(
                  color: ColorManager.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      Container(
                        width: AppSize.s6,
                        decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(6)),
                      ),
                      Flexible(
                        child: ListTile(
                          title: Row(
                            children: [
                              if(icon!=null)...[
                              Icon(icon,color: color,size: AppSize.s16,),
                              const SizedBox(width: AppSize.s4,),],
                              Text(
                                title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: color.withOpacity(.8),
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: AppPadding.p10),
                            child: Text(
                              description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                color: color,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            right: AppPadding.p10,
            top: AppPadding.p10,
            child: ZoomIn(
              delay: const Duration(milliseconds: 500),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.cancel,
                  color: color,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
