import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../src/features/core/data/models/file_model.dart';
import '../../../src/features/core/presentation/cubits/file_manager_cubit/file_manager_cubit.dart';
import '../../data/datasource/remote/api_response.dart';
import '../../data/models/base_model.dart';
import '../../data/models/info_file_model.dart';
import '../../helper/sizer_media_query.dart';
import '../../utils/color_manager.dart';
import '../../utils/values_manager.dart';
import 'file_download_widget.dart';
import 'file_manager_base.dart';
import 'file_upload_widget.dart';


class FileManagerWidget extends StatefulWidget {
   FileManagerWidget({super.key,  this.fileModels, this.uploadFile,  this.isShow=true, this.onChanged});

   List<FileModel>? fileModels;
   final bool isShow;
   final  Function(dynamic)? onChanged;

   final  Future<ApiResponse<BaseModel>> Function(BuildContext context,{required List<PlatformFile> files,String? key})?   uploadFile;

  @override
  State<FileManagerWidget> createState() => _FileManagerWidgetState();
}

class _FileManagerWidgetState extends State<FileManagerWidget> {
  final List<PlatformFile> _files=[];

   void pickerFile() async {
     final pickedFile = await FilePicker.platform.pickFiles(allowMultiple: true);
     if (pickedFile != null) {
       _files.addAll(pickedFile.files);
       setState(() {});
     }
   }
  late FileManagerCubit fileManagerCubit;
@override
  void initState() {
  fileManagerCubit=FileManagerCubit();
  context.read<FileManagerCubit>().init(widget.fileModels);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   return StatefulBuilder(builder: (context, filesState) {
      return Container(
        decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(14)),
        child: Column(
          children: [
            ListTile(
              title:  Text('Attached Files (${_files.length+(widget.fileModels?.length??0)}) : '),
              trailing: Padding(
                padding:  const EdgeInsets.symmetric(
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
                    (index) =>
                        FileManagerBase(
                          onChanged: widget.onChanged,//(list)=>print("DDd: ${list}"),
                          file: _files[index],
                            uploadFile: widget.uploadFile,// context.read<RequestBoxCubit>().repository.uploadRequestFiles,
                            builder:( context,state,fileModel,infoFile)=>
                            FileUploadWidget(file: infoFile??
                                InfoFile(
                                  name:_files[index].name,
                                  size:'${_files[index].size}',
                                  path:_files[index].path,
                                ),
                              onTap: () {
                                _files.removeAt(index);
                                context.read<FileManagerCubit>().removeFileAt(index);
                                filesState(() {});
                              },
                            )
                        )
              )..addAll(
                  widget.fileModels?.map((fileModel) =>
                  widget.isShow?FileDownloadWidget(file: fileModel,
                        onTap: () {
                          widget.fileModels?.remove(fileModel);
                          context.read<FileManagerCubit>().removeFile(fileModel);
                          filesState(() {});
                        },
                      ):
                      FileUploadWidget(file:
                      InfoFile(
                        name:fileModel.name,
                        size:'${fileModel.size}',
                        complete: true
                      ),
                        onTap: () {
                          widget.fileModels?.remove(fileModel);
                          context.read<FileManagerCubit>().removeFile(fileModel);
                          filesState(() {});
                        },
                      )
                  )??[]
              )..toList(),
            ),
            // Visibility(
            //     visible:_files.length>0,
            //     child: _files.length>0?ManagerFile(file: _files.last,):SizedBox.shrink())
          ],
        ),
      );
    });
    // if(file!=null)
    //  return UploadManagerFile(file: file!);
    // else if(FileModel!=null)
    //   return FileDownloadWidget(file:fileModel! );
    //   else if(infoFile!=null)
    //    return FileUploadWidget(file: infoFile!);
    //     else
    //       return SizedBox.shrink();
  }
}
