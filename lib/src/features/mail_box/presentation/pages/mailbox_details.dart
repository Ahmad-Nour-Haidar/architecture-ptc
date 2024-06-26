
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../../core/helper/operation_file.dart';
import '../../../../../core/widgets/image/profile_image.dart';
import '../../../../../core/widgets/refresh/refresh_base.dart';
import '../../../../../core/widgets/textfield_app.dart';
import '../cubits/request_box_cubit/request_box_cubit.dart';
import '/core/helper/sizer_media_query.dart';
import '/core/utils/theme_manager.dart';
import '/src/features/core/data/models/file_model.dart';
import '/src/features/mail_box/presentation/pages/create_mail_box_page.dart';
import '../../../../../core/utils/color_manager.dart';
import '../../../../../core/utils/values_manager.dart';
import '../../../../../core/widgets/button_app.dart';
import '../../data/models/request_box_model.dart';
import 'create_replay_mail_box_page.dart';

class MailBoxDetails extends StatelessWidget {
   MailBoxDetails({super.key, required this.requestBox});

   RequestBox requestBox;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(24)
                )
              ),
                isScrollControlled: true,
                constraints: BoxConstraints(
                  maxHeight: getHeight(context) - AppSize.s40,
                  minHeight: getHeight(context) / 2
                ),
                context: context,
                builder: (context) {
                  return  CreateReplayBoxPage(requestBox: requestBox,);
                  // return const AddReplayWidget();
                });
          },
          icon: const Icon(Icons.add),
          label: const Text('Add Replay')),
      appBar: AppBar(
        title: const Text(
          'Mail Box',
          style: TextStyle(
              color: ColorManager.primary, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: RefreshBase(

          onRefresh: () async {
            context.read<RequestBoxCubit>().getRequestBoxById(context,requestBoxId: requestBox.id??-1);
          },
          child: buildMailBoxDetails(context)),
    );
  }

  Widget buildMailBoxDetails(BuildContext context){
    context.read<RequestBoxCubit>().getRequestBoxById(context,requestBoxId: requestBox.id??-1);
    return
      BlocBuilder<RequestBoxCubit, RequestBoxState>(
          buildWhen: (previous, current)=>context.read<RequestBoxCubit>().buildMailBoxDetailsWhen(previous, current),
          builder: (context, state){

            requestBox=context.read<RequestBoxCubit>().requestBox??requestBox;
            return  context.read<RequestBoxCubit>().buildMailBoxDetails(
                  context,
                  state,
                SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(AppPadding.p12),
                      margin: const EdgeInsets.all(AppMargin.m12),
                      decoration: BoxDecoration(
                          color: ColorManager.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: ColorManager.black.withOpacity(.15),
                              blurRadius: 8,
                            )
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: CircleAvatar(
                              child:
                              ClipOval(
                                child: ProfileImage(
                                    url:requestBox.sendUser?.image
                                ),
                              ),
                            ),
                            title: Text(requestBox.sendUser?.completeName ?? 'Unknown'),
                            trailing: Text(
                                DateFormat.yMd().add_jm().format(requestBox.showDate ?? DateTime.now()),
                              style: const TextStyle(
                                fontSize: 10,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(requestBox.sendUser?.email ?? 'Unknown'),
                                const SizedBox(
                                  height: AppSize.s4,
                                ),
                                Text(
                                  'id : ${requestBox.sendUser?.id ??'Unknown' }',
                                  style:
                                  const TextStyle(color: ColorManager.primary, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          const Divider(),
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              requestBox.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: AppSize.s4,
                                ),
                                Text(
                                  requestBox.requestType ?? 'Unknown',
                                  style:
                                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                ),
                                const SizedBox(
                                  height: AppSize.s8,
                                ),
                                Text(
                                  requestBox.subTitle ?? '',
                                  style: const TextStyle(fontSize: 12),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: AppSize.s20,
                          ),
                          Theme(
                            data: ThemeManager.myTheme.copyWith(
                              dividerColor: Colors.transparent,
                            ),
                            child: ExpansionTile(
                              leading: TextButton.icon(
                                icon: const Icon(
                                  Icons.description,
                                  color: ColorManager.primary,
                                ),
                                label:  Text(
                                  'Files attached (${requestBox.files?.length??0}) : ',
                                  style: const TextStyle(color: ColorManager.primary),
                                ),
                                onPressed: null,
                              ),
                              iconColor: Colors.transparent,
                              trailing: TextButton(
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                  ),
                                  onPressed: null,
                                  child: const Text(
                                    'show files',
                                    style: TextStyle(
                                        color: ColorManager.primary, fontSize: 12),
                                  )),
                              title: const Text(''),
                              children: (requestBox.files ?? [])
                                  .map(
                                    (file) => FileDownloadWidget(
                                  file:file,
                                  onTap: () {
                                    // print(storageUrl(file.path??''));
                                     openUrl(path: getStorageUrl(file.path??''));
                                  },
                                ),
                              )
                                  .toList(),
                            ),
                          ),
                          Theme(
                            data: ThemeManager.myTheme.copyWith(
                              dividerColor: Colors.transparent,
                            ),
                            child: ExpansionTile(
                              initiallyExpanded: true,
                              leading: TextButton.icon(
                                icon: const Icon(
                                  Icons.reply_all,
                                  color: ColorManager.secondary,
                                ),
                                label: Text(
                                  'replies (${requestBox.replayBoxes?.length ?? 0}):',
                                  style:
                                  const TextStyle(color: ColorManager.primary, fontSize: 12),
                                ),
                                onPressed: null,
                              ),
                              iconColor: Colors.transparent,
                              trailing: TextButton(
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                  ),
                                  onPressed: null,
                                  child: const Text(
                                    'show replies',
                                    style: TextStyle(
                                        color: ColorManager.primary, fontSize: 12),
                                  )),
                              title: const Text(''),
                              children: (requestBox.replayBoxes ??
                                  [])
                                  .map(
                                    (replayBox) => Container(
                                  padding:
                                  const EdgeInsets.symmetric(vertical: AppPadding.p8),
                                  margin: const EdgeInsets.symmetric(
                                      vertical: AppMargin.m4),
                                  decoration: BoxDecoration(
                                      color: ColorManager.scaffoldBackgroundLight,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: ExpansionTile(
                                    key: Key(replayBox.toString()),
                                    onExpansionChanged: (c) {
                                      if (kDebugMode) {
                                      }
                                    },

                                    trailing: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          '2019,12,11 11:22',
                                          //  DateFormat.yMd().add_jm().format(requestBox.showDate ?? DateTime.now()),
                                          style: TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: AppSize.s4,
                                        ),
                                        Text(
                                          'Replies : ${replayBox.files?.length ?? 0}',
                                          style: const TextStyle(fontSize: 10, color: ColorManager.primary),
                                        )
                                      ],
                                    ),
                                    leading: CircleAvatar(
                                      child:
                                      ClipOval(
                                        child: ProfileImage(
                                            url:requestBox.sendUser?.image
                                        ),
                                      ),
                                    ),
                                    title:
                                    Text(replayBox.sendUser?.completeName ?? 'Unknown'),
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          replayBox.sendUser?.email ??
                                              'Unknown',
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: ColorManager.primary),
                                        ),
                                        const SizedBox(
                                          height: AppSize.s4,
                                        ),
                                        Text(
                                          replayBox.title,
                                          style: const TextStyle(
                                              fontSize: 12, color: ColorManager.black),
                                        ),
                                      ],
                                    ),
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(AppPadding.p12),
                                        child: Text(replayBox.subTitle ??
                                            ''),
                                      ),
                                      Column(
                                        children: (replayBox.files ??
                                            [

                                            ])
                                            .map((file) => FileDownloadWidget(
                                          file: file,
                                          onTap: () {},
                                        ))
                                            .toList(),
                                      )
                                    ],
                                  ),
                                ),
                              )
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
              );}
      );
  }
}

class AddReplayWidget extends StatefulWidget {
  const AddReplayWidget({
    super.key,
  });

  @override
  State<AddReplayWidget> createState() => _AddReplayWidgetState();
}

class _AddReplayWidgetState extends State<AddReplayWidget> {

  List<PlatformFile> _files = [];
  void pickerFile() async {
    final pickedFile = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (pickedFile != null) {
      _files = pickedFile.files;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Stack(
      alignment: Alignment.topRight,
      children: [
        Column(
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
                                controller: TextEditingController(text: 'Send to'),
                                fillColor: null,
                                textFieldHintColor: null,
                                onTap: null,
                              ),

                              const SizedBox(
                                height: AppSize.s20,
                              ),
                               TextFiledApp(
                                 readOnly: true,
                                 controller: TextEditingController(text: 'Type'),
                                 fillColor: null,
                                 textFieldHintColor: null,
                               ),
                              const SizedBox(
                                height: AppSize.s20,
                              ),
                              TextFiledApp(
                                hintText: 'Title',
                                fillColor: null,
                                textFieldHintColor: null,
                              ),

                              const SizedBox(
                                height: AppSize.s20,
                              ),
                              StatefulBuilder(builder: (context, filesState) {
                                return Container(
                                  decoration: BoxDecoration(
                                      color: ColorManager.white,
                                      borderRadius: BorderRadius.circular(14)),
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title: const Text('Attached Files (6) : '),
                                        trailing: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: AppPadding.p8),
                                          child: Container(
                                            width: getWidth(context) * 0.125,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                color: ColorManager.secondary),
                                            child: IconButton(
                                              onPressed: pickerFile,
                                              icon: const Icon(
                                                Icons.add,
                                                color: ColorManager.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: List.generate(
                                          _files.length,
                                              (index) => FileUploadWidget(
                                            file: FileModel(
                                              name: index.toString(),
                                            ),
                                            onTap: () {
                                              _files.removeAt(index);
                                              setState(() {});
                                            },
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              })
                            ],
                          ),
                        ),
                      )),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p14),
                      child: ButtonApp(
                        text: 'Send',
                        onPressed: () {},
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        CircleAvatar(
          backgroundColor: ColorManager.white,
          child: IconButton(icon: const Icon(Icons.close_outlined),onPressed: (){
            Navigator.pop(context);
          },),
        ),
      ],
    );

  }
}
