
import 'package:architecture_ptc/core/widgets/widgets_Informative/empty_data_view.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../../../core/data/models/base_model.dart';
import '../../../../../../core/domain/error_handler/network_exceptions.dart';
import '../../../../../../core/widgets/constants.dart';
import '../../../../../../core/widgets/widgets_Informative/error_view.dart';
import '../../../../../../core/widgets/widgets_Informative/loading_data_view.dart';
import '../../../data/models/request_box_model.dart';
import '../../../domain/repositories/request_box_repository.dart';

part 'recive_request_box_state.dart';
part 'recive_request_box_cubit.freezed.dart';

class ReciveRequestBoxCubit extends Cubit<ReciveRequestBoxState> {
  final RequestBoxRepository _repository;
  ReciveRequestBoxCubit(this._repository) : super(const ReciveRequestBoxState.initial());
  RequestBoxes? requestBoxes;
  BaseModel? baseModel;
  String? currentNameList;


  void init()  {
    baseModel=null;
    requestBoxes=null;
    //emit(const ReciveRequestBoxState.initial(),);
  }

  Future<void> getRequestBoxes(
    BuildContext context,
    String nameList  ///send || recived
  ) async {
    if(currentNameList!=nameList){
      currentNameList=nameList;
      baseModel=null;
    }
    if (baseModel!=null&&baseModel?.meta?.to == null) return;
    emit(
      const ReciveRequestBoxState.loadingPagination(),
    );
    int pageKey = (baseModel?.meta?.currentPage??-1) + 1;
    if(pageKey==0) {
      requestBoxes=RequestBoxes(listRequestBox: []);
    }

    final response = await _repository.getRequestBoxes(page: pageKey,nameList:nameList);
    response.when(
      success: (data) async {
        baseModel = data;
        requestBoxes?.listRequestBox.addAll(data.data.listRequestBox);
        if(requestBoxes?.listRequestBox.isEmpty??true) {
          emit(ReciveRequestBoxState.emptyPagination(data.message),);
        } else {
          emit(ReciveRequestBoxState.successPagination(requestBoxes, data.message),);
        }
      },
      failure: (networkException) {
        emit(
          ReciveRequestBoxState.failurePagination(networkException),
        );
        Constants.onNetworkFailure(context,networkException:networkException);
      },
    );
  }

  ///buildMailBoxDetails
  bool buildListRecBoxesWhen(ReciveRequestBoxState previous,ReciveRequestBoxState current){
    if(current==previous) return false;
    return current.maybeWhen(
        loadingPagination: () =>true ,
        emptyPagination: (_) =>true ,
        successPagination: (_,__) =>true ,
        failurePagination: (_) =>true ,
        orElse: () =>false
    );
  }
  Widget buildListRecBoxes(BuildContext context,ReciveRequestBoxState state,Widget child)=>
      state.maybeWhen(
          loadingPagination:()=>const LoadingDataView(),
          failurePagination: (networkExceptions)=> ErrorView(networkExceptions:networkExceptions),
          emptyPagination:(message)=>EmptyDataView() ,
          orElse: () =>child
      );

}
