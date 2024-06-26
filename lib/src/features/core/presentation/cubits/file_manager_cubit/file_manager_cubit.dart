import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../core/data/datasource/remote/api_response.dart';
import '../../../../../../core/data/models/base_model.dart';
import '../../../../../../core/data/models/info_file_model.dart';
import '../../../data/models/file_model.dart';


part 'file_manager_state.dart';
part 'file_manager_cubit.freezed.dart';

class FileManagerCubit extends Cubit<FileManagerState> {
  FileModel? fileModel;
  List<FileModel> fileModels=[];

  FileManagerCubit() : super(const FileManagerState.initial());


  void init(List<FileModel>? fileModels){
    fileModel=null;
    this.fileModels=fileModels??[];
  }


  Future<void> uploadFile(BuildContext context,{required List<PlatformFile> files,required InfoFile infoFile
  , required Future<ApiResponse<BaseModel>> Function(BuildContext context,{required List<PlatformFile> files,String? key})  uploadFile
  }) async {

    for(PlatformFile file in files){
      final response =await uploadFile(context, files:[file],key:infoFile.key);

      response.when(
        success: (data) async {
          if(data.data is FileModel) {
            fileModels.add(data.data);
          } else if(data.data is FileModels)
             fileModels.addAll((data.data as FileModels).listFileModel);

            emit(const FileManagerState.initial(),);
            emit(FileManagerState.change(fileModels),);
        },
        failure: (networkException) {
          // Constants.showTOAST(context,
          //     textToast: MessageApi.findTextToast(
          //         NetworkExceptions.getErrorMessage(networkException)));
          // BlocProvider.of<AdvanceCubit>(context)
          //     .failureAdvance(context, networkException);
        },
      );
    }
  }

  Future<void> removeFileAt(int index) async {
    if (fileModels.length > index) {
      fileModels.removeAt(index);
      emit(const FileManagerState.initial(),);
      emit(FileManagerState.change(fileModels),);
    }
  }
  Future<void> removeFile(FileModel fileModel) async {

    fileModels.remove(fileModel);
    emit(const FileManagerState.initial(),);
    emit(FileManagerState.change(fileModels),);

  }



}
