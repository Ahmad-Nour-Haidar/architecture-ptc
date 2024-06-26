
import 'package:architecture_ptc/src/features/cache/data/models/users.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/helper/sizer_media_query.dart';
import '../../../../../core/widgets/button_app.dart';
import '../../../../../core/widgets/file_manager/file_manager_widget.dart';
import '../../../../../core/widgets/textfield_app.dart';
import '../../../core/data/models/file_model.dart';
import '../../data/models/request_box_model.dart';
import '../cubits/replay_box_cubit/replay_box_cubit.dart';
import '../cubits/request_box_cubit/request_box_cubit.dart';
import '/core/utils/color_manager.dart';
import '../../../../../core/utils/values_manager.dart';
class CreateReplayBoxPage extends StatefulWidget {
  const CreateReplayBoxPage({super.key, required this.requestBox});

  final RequestBox requestBox;
  @override
  State<CreateReplayBoxPage> createState() => _CreateReplayBoxPageState();
}

class _CreateReplayBoxPageState extends State<CreateReplayBoxPage>
    with TickerProviderStateMixin {
  late AnimationController _hideFabAnimation;
  final titleController= TextEditingController();
  final subTitleController= TextEditingController();

  final List<PlatformFile> _files = [];
  late  List<FileModel> _fileModels = [];
  UserModel? _user ;
  String? _typeModel;

  void pickerFile() async {
    final pickedFile = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (pickedFile != null) {
      _files.addAll(pickedFile.files);
      setState(() {});
    }
  }
  Future<void> createReplayBox(BuildContext context) async {

    await BlocProvider.of<ReplayBoxCubit>(context).createReplayBox(context,
        requestId:widget.requestBox.id,
        title: titleController.value.text,
        subTitle: subTitleController.value.text,
       fileIds: _fileModels.map((e) => e.id??-1).toList());
  }
  @override
  void initState() {
      _user=widget.requestBox.recivedUser ;
     _typeModel=widget.requestBox.requestType;
    _hideFabAnimation =
        AnimationController(vsync: this, duration: kThemeAnimationDuration);
    super.initState();
  }

  @override
  void dispose() {
    _hideFabAnimation.dispose();
    super.dispose();
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification.depth == 0) {
      if (notification is UserScrollNotification) {
        final UserScrollNotification userScroll = notification;
        switch (userScroll.direction) {
          case ScrollDirection.forward:
            if (userScroll.metrics.maxScrollExtent !=
                userScroll.metrics.minScrollExtent) {
              print('object Forward ${userScroll.metrics.minScrollExtent}');
              print('object Forward ${userScroll.metrics.maxScrollExtent}');
              _hideFabAnimation.forward();
            }
            break;
          case ScrollDirection.reverse:
            if (userScroll.metrics.maxScrollExtent !=
                userScroll.metrics.minScrollExtent) {
              _hideFabAnimation.reverse();
              print('object Revers ${userScroll.metrics.minScrollExtent}');
              print('object Revers ${userScroll.metrics.maxScrollExtent}');
            }
            break;
          case ScrollDirection.idle:
            break;
        }
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child:  Stack(
          alignment: Alignment.topRight,
          children: [ Column(
          children: [
            Center(
              child: Container(
                width: getWidth(context) / 8,
                height: AppSize.s4,
                margin: const EdgeInsets.all(AppMargin.m10),
                padding: const EdgeInsets.all(AppPadding.p4),
                decoration:  BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorManager.secondary,
                ),
              ),
            ),
            Expanded(
              child: CustomScrollView(
                  slivers: [
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.all(AppPadding.p16),
                        child: Text(
                          'Schedule all mails in one place',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: AppSize.s16),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                        child: Padding(
                      padding: const EdgeInsets.all(AppPadding.p16),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFiledApp(
                              readOnly: true,
                              controller: TextEditingController(text:_user?.completeName ),
                              hintText: 'Send To',
                              fillColor: null,
                              textFieldHintColor: null,
                            ),

                            const SizedBox(
                              height: AppSize.s20,
                            ),
                            TextFiledApp(
                              readOnly: true,
                              controller: TextEditingController(text:_typeModel ),
                              hintText: 'Request Type',
                              fillColor: null,
                              textFieldHintColor: null,
                            ),




                            const SizedBox(
                              height: AppSize.s20,
                            ),
                            TextFiledApp(
                              controller: titleController,
                              hintText: 'Title',
                              fillColor: null,
                              textFieldHintColor: null,
                            ),
                            const SizedBox(
                              height: AppSize.s20,
                            ),


                            FileManagerWidget(
                              onChanged: (list)=>_fileModels=list,
                                  //print("DDd: ${list}"),
                              uploadFile: context.read<RequestBoxCubit>().repository.uploadRequestFiles,
                            )

                          ],
                        ),
                      ),
                    )),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p14),
                        child: ButtonApp(
                          text: 'Send',
                          onPressed: () async {
                            await createReplayBox(context);
                          },
                        ),
                      ),
                    )
                  ],
                ),
            ),
          ],
        ),]
      ),

    );
  }
}

