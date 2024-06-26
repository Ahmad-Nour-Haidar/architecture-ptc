
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../core/data/models/info_file_model.dart';
import '../../../../../../core/domain/error_handler/network_exceptions.dart';
import '../../../data/models/file_model.dart';


part 'upload_manager_state.dart';
part 'upload_manager_cubit.freezed.dart';

class UploadManagerCubit extends Cubit<UploadManagerState> {

  final keyDefault='last';
  List<FileModel> fileModels=[];
  Map<String,InfoFile> uploadManagerMap={};
  UploadManagerCubit() : super(const UploadManagerState.initial());


  void init(){
    fileModels.clear();
  }
  void _initUploadManager(BuildContext context)  {
    uploadManagerMap.clear();
    fileModels.clear();
 }

  void initFileWithoutKey({required InfoFile file}){
    file.key==null?file.key=DateTime.now().toIso8601String()+(file.name??''):'';
    uploadManagerMap[file.key??keyDefault]=file;

  }
 void initFile({required InfoFile file, String? key}){
    uploadManagerMap[key??keyDefault]=file;
 }
  void uploadFile({String? key,required String progress}){

    key=key??keyDefault;
    !uploadManagerMap.containsKey(key)?uploadManagerMap[key]=InfoFile():'';
    uploadManagerMap[key]?.progress=progress;
    uploadManagerMap[key]?.run=true;
    uploadManagerMap[key]?.complete=false;

    emit(UploadManagerState.upload(uploadManagerMap[key],progress));
  }
  void failureUploadFile({String? key,NetworkExceptions? networkExceptions}){
    key=key??keyDefault;
    uploadManagerMap[key]?.run=false;
    emit(UploadManagerState.failure(networkExceptions));
  }
  void completeUploadFile({String? key}){
    key=key??keyDefault;
    uploadManagerMap[key]?.run=false;
    uploadManagerMap[key]?.complete=true;

    emit(UploadManagerState.success(uploadManagerMap[key],null));
  }
  void pauseUploadFile({String? key}){
    key=key??keyDefault;
    uploadManagerMap[key]?.run=false;
    emit(UploadManagerState.pause(uploadManagerMap[key]));
  }



}
