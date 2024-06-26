
import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../../../core/data/models/base_model.dart';
import '../../../../../../core/domain/error_handler/network_exceptions.dart';
import '../../../../../../core/routing/app_router.dart';
import '../../../../../../core/widgets/constants.dart';
import '../../../../core/data/models/file_model.dart';
import '../../../data/models/replay_box_model.dart';
import '../../../domain/repositories/replay_box_repository.dart';

part 'replay_box_state.dart';
part 'replay_box_cubit.freezed.dart';

class ReplayBoxCubit extends Cubit<ReplayBoxState> {
  final ReplayBoxRepository _repository;
  ReplayBoxCubit(this._repository) : super(const ReplayBoxState.initial());
  ReplayBox? replayBox;
  ReplayBoxes? replayBoxes;
  BaseModel? baseModel;
  String? currentNameList;
  FileModels? fileModels;

  Future<void> getReplayBoxById(
    BuildContext context,{required int replayBoxId}
  ) async {
    emit(
      const ReplayBoxState.loading(),
    );
    final response = await _repository.getReplayBoxById(replayBoxId:replayBoxId);
    response.when(
      success: (data) async {
        replayBox = data.data;
        baseModel = data;
        emit(
          ReplayBoxState.success(replayBox, data.message),
        );
      },
      failure: (networkException) {
        emit(
          ReplayBoxState.failure(networkException),
        );
        Constants.onNetworkFailure(context,networkException:networkException);
      },
    );
  }

  Future<void> getReplayBoxes(
    BuildContext context,
  ) async {

    if (baseModel!=null&&baseModel?.meta?.to == null) return;
    emit(
      const ReplayBoxState.loadingPagination(),
    );

    int pageKey = baseModel?.meta?.currentPage??-1 + 1;
    if(pageKey==0) {
      replayBoxes=ReplayBoxes(listReplayBox: []);
    }

    final response = await _repository.getReplayBoxes(page: pageKey);
    response.when(
      success: (data) async {
        baseModel = data;
        replayBoxes?.listReplayBox.addAll(data.data.listReplayBox);
        emit(
          ReplayBoxState.successPagination(replayBoxes, data.message),
        );
      },
      failure: (networkException) {
        emit(
          ReplayBoxState.failurePagination(networkException),
        );
        Constants.onNetworkFailure(context,networkException:networkException);
      },
    );
  }


  Future<void> createReplayBox(
      BuildContext context,{
        required int? requestId,
        required String title,
        required String? subTitle,
        required List<int>? fileIds,
      }
      ) async {
    Constants.loading(context);
    replayBox=ReplayBox(title: title,requestId: requestId,subTitle: subTitle);
    final response = await _repository.createReplayBox(replayBox:replayBox!,fileIds:fileIds
    );
    response.when(
      success: (data) async {
        goRouter.pop();
        goRouter.pop();
        Constants.onSuccess(context,message: data.message);

      },
      failure: (networkException) {
        goRouter.pop();
        Constants.onNetworkFailure(context,networkException:networkException);
      },
    );
  }

  // Future<void> createReplayBox(
  //     BuildContext context,{
  //       required int? recivedId,
  //       required String title,
  //       required String? subTitle,
  // }
  //     ) async {
  // replayBox=ReplayBox(title: title,recivedId: recivedId,subTitle: subTitle);
  //   final response = await _repository.createReplayBox(replayBox:replayBox!,fileIds:fileModels?.getFileIds());
  //   response.when(
  //     success: (data) async {
  //       Constants.onSuccess(context,message: data.message);
  //     },
  //     failure: (networkException) {
  //       Constants.onNetworkFailure(context,networkException:networkException);
  //     },
  //   );
  // }

  Future<void> uploadReplayFiles(
      BuildContext context,{
        required List<PlatformFile> files,
      }
      ) async {
    final response = await _repository.uploadReplayFiles(files:files);
    response.when(
      success: (data) async {
        fileModels ??= FileModels(listFileModel: []);
        fileModels?.listFileModel.addAll(data.data.listFileModel);
        Constants.onSuccess(context,message: data.message);
      },
      failure: (networkException) {
        Constants.onNetworkFailure(context,networkException:networkException);
      },
    );
  }

  Future<void> updateReplayBox(
      BuildContext context,{
        required ReplayBox replayBox
      }
      ) async {
    final response = await _repository.updateReplayBox(replayBox:replayBox, replayBoxId: replayBox.id??-1);
    response.when(
      success: (data) async {
        this.replayBox=replayBox;
        Constants.onSuccess(context,message: data.message);
      },
      failure: (networkException) {
        Constants.onNetworkFailure(context,networkException:networkException);
      },
    );
  }
  Future<void> deleteReplayBox(
      BuildContext context,{
        required int replayBoxId
      }
      ) async {
    final response = await _repository.deleteReplayBox(replayBoxId:replayBoxId );
    response.when(
      success: (data) async {
        replayBox=null;
        Constants.onSuccess(context,message: data.message);
      },
      failure: (networkException) {
        Constants.onNetworkFailure(context,networkException:networkException);
      },
    );
  }
}
