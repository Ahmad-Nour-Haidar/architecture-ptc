import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../src/features/core/data/models/file_model.dart';
import '../../../src/features/core/presentation/cubits/file_manager_cubit/file_manager_cubit.dart';
import '../../../src/features/core/presentation/cubits/upload_manager_cubit/upload_manager_cubit.dart';
import '../../data/datasource/remote/api_response.dart';
import '../../data/models/base_model.dart';
import '../../data/models/info_file_model.dart';

class FileManagerBase extends StatefulWidget {
  const FileManagerBase({super.key, required this.builder,  this.fileModel,  this.uploadFile, this.onChanged, this.file,});
  final FileModel? fileModel;
  final PlatformFile? file;
  final Widget Function(BuildContext context,UploadManagerState state,FileModel?,InfoFile?)  builder;
  final  Future<ApiResponse<BaseModel>> Function(BuildContext context,{required List<PlatformFile> files,String? key})?  uploadFile;
  final  Function(dynamic)? onChanged;

  @override
  State<FileManagerBase> createState() => _FileManagerBaseState();
}

class _FileManagerBaseState extends State<FileManagerBase> {
   InfoFile? infoFile;

  uploadFile(context){
    if(widget.file!=null&&infoFile==null){
      infoFile=InfoFile(name: widget.file!.name,path:  widget.file!.path,size: '${widget.file!.size}');
      BlocProvider.of<UploadManagerCubit>(context).initFileWithoutKey(file: infoFile!);
      widget.uploadFile!=null?BlocProvider.of<FileManagerCubit>(context).uploadFile(context,files: [widget.file!],infoFile: infoFile!, uploadFile: widget.uploadFile!):'';
    }
  }
  @override
  Widget build(BuildContext context) {

    return  BlocListener<FileManagerCubit,FileManagerState>(
        listener: (context,state)=>state.whenOrNull(change: widget.onChanged,),
      child:  BlocProvider<UploadManagerCubit>(
        create:(context) =>UploadManagerCubit() ,
          child: BlocBuilder<UploadManagerCubit,UploadManagerState>(
              builder:(context,state){
                uploadFile(context);
             return widget.builder( context,state,widget.fileModel,infoFile);
              }

          )
      ),

    );
  }
}
