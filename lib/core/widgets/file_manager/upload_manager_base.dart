import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../src/features/core/presentation/cubits/file_manager_cubit/file_manager_cubit.dart';
import '../../../src/features/core/presentation/cubits/upload_manager_cubit/upload_manager_cubit.dart';
import '../../data/models/info_file_model.dart';

class UploadManagerBase extends StatefulWidget {
  const UploadManagerBase({super.key, required this.builder, required this.file, required this.uploadFile, this.onChanged,});
  final PlatformFile file;
  final Widget Function(BuildContext context,UploadManagerState state,InfoFile infoFile)  builder;
  final  Function( PlatformFile file,InfoFile infoFile )  uploadFile;
  final  Function(dynamic)? onChanged;

  @override
  State<UploadManagerBase> createState() => _UploadManagerBaseState();
}

class _UploadManagerBaseState extends State<UploadManagerBase> {
  late InfoFile infoFile;
  @override
  void initState() {
    infoFile=InfoFile(name: widget.file.name,path:  widget.file.path,size: '${widget.file.size}');
    context.read<UploadManagerCubit>().initFileWithoutKey(file: infoFile);


    widget.uploadFile( widget.file,infoFile);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  BlocListener<FileManagerCubit,FileManagerState>(
        listener: (context,state)=>state.whenOrNull(change: widget.onChanged,
    ),
      child:  BlocBuilder<UploadManagerCubit,UploadManagerState>(
          builder: (context,state)=>
              widget.builder( context,state,infoFile)

      ),

    );
  }
}
