
import 'package:architecture_ptc/src/features/cache/data/models/users.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../../../../core/helper/operation_file.dart';
import '../../../../../core/helper/sizer_media_query.dart';
import '../../../../../core/widgets/button_app.dart';
import '../../../../../core/widgets/file_manager/file_manager_widget.dart';
import '../../../core/data/models/file_model.dart';
import '../../../core/data/models/type_model.dart';
import '../cubits/request_box_cubit/request_box_cubit.dart';
import '/core/utils/color_manager.dart';
import '/core/widgets/textfield_app.dart';

import '../../../../../core/utils/values_manager.dart';


class CreateMailBoxPage extends StatefulWidget {
  const CreateMailBoxPage({super.key});

  @override
  State<CreateMailBoxPage> createState() => _CreateMailBoxPageState();
}

class _CreateMailBoxPageState extends State<CreateMailBoxPage>
  {
  final titleController= TextEditingController();
  final subTitleController= TextEditingController();
  final List<PlatformFile> _files = [];
  List<FileModel> _fileModels = [];
  UserModel? _user ;
  TypeModel? _typeModel;

  void pickerFile() async {
    final pickedFile = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (pickedFile != null) {
      _files.addAll(pickedFile.files);
      setState(() {});
    }
  }
  Future<void> createRequestBox() async {

    await context.read<RequestBoxCubit>().createRequestBox(context,
        recivedId: _user?.id,
        title: titleController.value.text,
        subTitle: subTitleController.value.text,
        requestTypeId: _typeModel?.id, fileIds: _fileModels.map((e) => e.id??-1).toList());
  }
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                                ///ToDo code here...
                                // AllUserDropDown(
                                //
                                //   // builder: ({BuildContext? context,CategoryModel? item})=>SizedBox.shrink(),
                                //     onSelectionChanged: (selected){
                                //       _user=selected;
                                //       print(selected);
                                //     }),
                                // const SizedBox(
                                //   height: AppSize.s20,
                                // ),
                                ///ToDo code here...
                                // TypeModelDropDown(
                                //     nameDropDown: "Request Type",
                                //
                                //     onSelectionChanged: (selected){
                                //       _typeModel=selected;
                                //     }, funGetItems: ({page, term})=> context.read<RequestBoxCubit>().repository.getRequestBoxTypes(page: page,term: term)),
      
      
      
                                // const SizedBox(
                                //   height: AppSize.s20,
                                // ),
                                TextFiledApp(
                                  controller: titleController,
                                  hintText: 'Title',
                                  fillColor: null,
                                  textFieldHintColor: null,
                                ),
                                const SizedBox(
                                  height: AppSize.s20,
                                ),
                                TextFiledApp(
                                  controller: subTitleController,
                                  hintText: 'Sub Title',
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
                            await createRequestBox();
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

class FileUploadWidget extends StatelessWidget {
  const FileUploadWidget({
    super.key,
    required this.file,
    this.onTap,
    this.isComplete = false,
  });

  final FileModel file;
  final VoidCallback? onTap;
  final bool isComplete;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: isComplete
          ? IconButton(
          onPressed: onTap,
          icon: const Icon(
            Icons.delete,
            color: ColorManager.error,
          ))
          : null,
      leading: const CircleAvatar(
        child: Icon(
          Icons.file_present_outlined,
        ),
      ),
      title: isComplete
          ? Text(file.name ?? '')
          : LinearPercentIndicator(
        padding: EdgeInsets.zero,
        animation: true,
        curve: Curves.easeInOut,
        percent: 0.5,
        progressColor: ColorManager.primary,
      ),
      subtitle: Text('${file.size ?? 0}'),
    );
  }
}

class FileDownloadWidget extends StatelessWidget {
  const FileDownloadWidget({
    super.key,
    required this.file,
    this.onTap,
  });

  final FileModel file;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: IconButton(
          onPressed: onTap,
          icon: const Icon(
            Icons.download,
            color: ColorManager.secondary,
          )),
      leading: const CircleAvatar(
        child: Icon(
          Icons.file_present_outlined,
        ),
      ),
      title: Text(file.name ?? ''),
      subtitle: Text(formatFileSize((file.size ?? 0))),
    );
  }
}
