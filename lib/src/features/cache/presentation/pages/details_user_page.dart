import 'package:flutter/material.dart';

import '../../../../../core/helper/helpers.dart';
import '../../../../../core/widgets/image/profile_image.dart';
import '../../../../../core/widgets/refresh/refresh_base.dart';
import '../../data/datasource/configuration/users_cache.dart';
import '../../data/models/users.dart';
import '/core/helper/sizer_media_query.dart';
import '/core/utils/values_manager.dart';
import '../../../../../core/utils/color_manager.dart';

class DetailsUserPage extends StatefulWidget {
  const DetailsUserPage({super.key, required this.id});
  final int? id;

  @override
  State<DetailsUserPage> createState() => _DetailsUserPageState();
}

class _DetailsUserPageState extends State<DetailsUserPage> {
  final ScrollController scrollController = ScrollController();
  late UserModel? user;

  @override
  void initState() {
    // user=UserModel.fromJson(getUserById(widget.id));
    user=UsersCache.instance.getUser(widget.id);
    print(user?.toJson());
     super.initState();
  }
  Future<void> _onRefresh()async {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text(
          'Details User Page',
          style: TextStyle(
            color: ColorManager.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body:  RefreshBase(
        onRefresh:_onRefresh,
        child: builderDetailsCourse(context),

      ),
    );
  }
  Widget builderDetailsCourse(BuildContext context){

    return
      SingleChildScrollView(
          controller: scrollController,
          child:
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(AppPadding.p14),
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: ColorManager.shadowColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child:
                        ProfileImage(
                          url: user?.image,
                           // ??'https://th.bing.com/th/id/OIP.6m-225JfAsDczM6b7rMeQgHaEK?rs=1&pid=ImgDetMain',
                          width:getWidth(context) / 1.75,
                          height:  getWidth(context) / 3,
                        )
                    ),
                    const SizedBox(
                      height: AppSize.s10,
                    ),
                    Text(
                      '# ${formatText(user?.id)}',
                      style: const TextStyle(
                        color: ColorManager.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                      ),
                    ),
                    const SizedBox(
                      height: AppSize.s10,
                    ),
                    Wrap(
                      runSpacing: AppSize.s4,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: AppMargin.m4),
                          padding: const EdgeInsets.all(
                            AppPadding.p8,
                          ),
                          decoration: BoxDecoration(
                              color: ColorManager.primary,
                              borderRadius: BorderRadius.circular(100.0)),
                          child:  Text(
                            formatText(user?.completeName),
                            style: const TextStyle(
                                color: ColorManager.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: AppSize.s10,
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        formatText(user?.about),
                        style: const TextStyle(
                          color: ColorManager.endColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: AppSize.s10,
                    ),

                  ],
                ),
              ),
            ],
          )
      );
  }


}
