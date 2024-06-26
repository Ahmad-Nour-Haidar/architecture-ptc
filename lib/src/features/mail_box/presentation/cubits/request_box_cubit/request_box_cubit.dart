import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../../../../core/data/models/base_model.dart';
import '../../../../../../core/data/models/info_file_model.dart';
import '../../../../../../core/data/utils/paginate_adapter.dart';
import '../../../../../../core/domain/error_handler/network_exceptions.dart';
import '../../../../../../core/routing/app_router.dart';
import '../../../../../../core/widgets/constants.dart';
import '../../../../../../core/widgets/shimmer/load_List.dart';
import '../../../../../../core/widgets/widgets_Informative/empty_data_view.dart';
import '../../../../../../core/widgets/widgets_Informative/error_view.dart';
import '../../../../../../core/widgets/widgets_Informative/loading_data_view.dart';
import '../../../../core/data/models/file_model.dart';
import '../../../data/models/info_box_model.dart';
import '../../../data/models/request_box_model.dart';
import '../../../domain/repositories/request_box_repository.dart';

part 'request_box_state.dart';
part 'request_box_cubit.freezed.dart';

class RequestBoxCubit extends Cubit<RequestBoxState> {
  final RequestBoxRepository repository;
  RequestBoxCubit(this.repository) : super(const RequestBoxState.initial()) {
    ///Code Paging here
  }

  RequestBox? requestBox;
  List<RequestBox> requestsBox = [];
  List<RequestBox> sendRequestsBox = [];
  List<RequestBox> recRequestsBox = [];
  RequestBoxes? requestBoxes;
  BaseModel? baseModel;
  String? currentNameList;
  FileModels? fileModels;
  InfoBox? infoBox;

  onRefresh(BuildContext context) {}
  void init(BuildContext context) {
    initRequestBox();
    fileModels = null;

    ///Code init paging here
  }

  void initRequestBox() {
    baseModel = null;
  }

  Future<void> getRequestBoxById(BuildContext context,
      {required int requestBoxId}) async {
    emit(
      const RequestBoxState.loading(),
    );
    final response =
        await repository.getRequestBoxById(requestBoxId: requestBoxId);
    response.when(
      success: (data) async {
        requestBox = data.data;
        emit(
          RequestBoxState.success(requestBox, data.message),
        );
      },
      failure: (networkException) {
        emit(
          RequestBoxState.failure(networkException),
        );
        Constants.onNetworkFailure(context, networkException: networkException);
      },
    );
  }

  Future<void> getInfoBox(
    BuildContext context,
  ) async {
    /// code here
  }

  Future<void> getSendRequestBoxes(BuildContext context,
      {required int? pageKey}) async {
    /// code here
  }

  Future<void> createRequestBox(
    BuildContext context, {
    required int? recivedId,
    required String title,
    required String? subTitle,
    required int? requestTypeId,
    required List<int>? fileIds,
  }) async {
    Constants.loading(context);
    requestBox = RequestBox(
        title: title,
        recivedId: recivedId,
        subTitle: subTitle,
        requestTypeId: requestTypeId);
    final response = await repository.createRequestBox(
        requestBox: requestBox!, fileIds: fileIds //fileModels?.getFileIds()
        );
    response.when(
      success: (data) async {
        goRouter.pop();
        goRouter.pop();
        Constants.onSuccess(context, message: data.message);
      },
      failure: (networkException) {
        goRouter.pop();
        Constants.onNetworkFailure(context, networkException: networkException);
      },
    );
  }

  Future<void> uploadRequestFiles(
    BuildContext context, {
    required List<PlatformFile> files,
    InfoFile? infoFile,
  }) async {
    final response = await repository.uploadRequestFiles(context,
        files: files, key: infoFile?.key);
    response.when(
      success: (data) async {
        fileModels ??= FileModels(listFileModel: []);
        fileModels?.listFileModel.addAll(data.data.listFileModel);
        Constants.onSuccess(context, message: data.message);
      },
      failure: (networkException) {
        Constants.onNetworkFailure(context, networkException: networkException);
      },
    );
  }

  ///buildListSendBoxes
  // bool buildListSendBoxesWhen(RequestBoxState previous,RequestBoxState current){
  // /// code here
  // }
  // Widget buildListSendBoxes(BuildContext context,RequestBoxState state,Widget child)=>
  // /// code here;

  ///buildMailBoxDetails
  bool buildMailBoxDetailsWhen(
      RequestBoxState previous, RequestBoxState current) {
    if (current == previous) return false;
    return current.maybeWhen(
        loading: () => true,
        empty: (_) => true,
        success: (_, __) => true,
        failure: (_) => true,
        orElse: () => false);
  }

  Widget buildMailBoxDetails(
          BuildContext context, RequestBoxState state, Widget child) =>
      state.maybeWhen(
          loading: () => LoadingDataView(),
          empty: (message) => EmptyDataView(),
          failure: (networkExceptions) =>
              ErrorView(networkExceptions: networkExceptions),
          orElse: () => child);

  ///buildMailBoxPage
  // bool buildMailBoxPageWhen(RequestBoxState previous,RequestBoxState current){
  // /// code here
  // }
  // Widget buildMailBoxPage(BuildContext context,RequestBoxState state,Widget child)=>
// /// code here;
}
