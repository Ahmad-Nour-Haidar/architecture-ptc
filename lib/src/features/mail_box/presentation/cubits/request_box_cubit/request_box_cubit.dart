
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
import '../recicve_request_box_cubit/recive_request_box_cubit.dart';


part 'request_box_state.dart';
part 'request_box_cubit.freezed.dart';

class RequestBoxCubit extends Cubit<RequestBoxState> {
  final RequestBoxRepository repository;
  RequestBoxCubit(this.repository) : super(const RequestBoxState.initial()){
    pagingAdapterSend=PagingAdapter(fetchItems: getSendRequestBoxes);
    pagingAdapterRec=PagingAdapter(fetchItems: getRecRequestBoxes);
  }

  RequestBox? requestBox;
  List<RequestBox> requestsBox=[];
  List<RequestBox> sendRequestsBox=[];
  List<RequestBox> recRequestsBox=[];
  RequestBoxes? requestBoxes;
  BaseModel? baseModel;
  String? currentNameList;
  FileModels? fileModels;
  InfoBox? infoBox;
  bool first=true;

  late final PagingAdapter<RequestBox> pagingAdapterSend;
  late final PagingAdapter<RequestBox> pagingAdapterRec;
  onRefresh(BuildContext context){
    getInfoBox(context);
    pagingAdapterSend.refresh();
    pagingAdapterRec.refresh();
  }
  void init(BuildContext context)  {
    initRequestBox();
    fileModels=null;
    infoBox=null;

    pagingAdapterSend.init();
    pagingAdapterSend.initPageRequestListener(context,pagingAdapterSend.pagingController);

    pagingAdapterRec.init();
    pagingAdapterRec.initPageRequestListener(context,pagingAdapterRec.pagingController);

   // emit(const RequestBoxState.initial(),);
  }
  void initRequestBox()  {
    baseModel=null;
    requestBoxes=null;
    currentNameList=null;
    first=true;

    sendRequestsBox.clear();
    recRequestsBox.clear();
  }

  Future<void> getRequestBoxById(
      BuildContext context,{required int requestBoxId}
      ) async {
    emit(
      const RequestBoxState.loading(),
    );
    final response = await repository.getRequestBoxById(requestBoxId:requestBoxId);
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
        Constants.onNetworkFailure(context,networkException:networkException);
      },
    );
  }

  Future<void> getInfoBox(
      BuildContext context,
      ) async {
    emit(
      const RequestBoxState.loadingPage(),
    );
    init(context);
    context.read<ReciveRequestBoxCubit>().init();
    final response = await repository.getInfoBox();
    response.when(
      success: (data) async {
        infoBox = data.data;

        emit(
          RequestBoxState.successPage(infoBox, data.message),
        );
      },
      failure: (networkException) {
        emit(
          RequestBoxState.failurePage(networkException),
        );
        Constants.onNetworkFailure(context,networkException:networkException);
      },
    );
  }


  ///old api
  Future<void> getRequestBoxesBase(
      BuildContext context,{
      required RequestBoxState Function()  loading,
      required RequestBoxState Function(String? message)  empty,
      required RequestBoxState Function(RequestBoxes? data,String? message) success,
      required RequestBoxState Function(NetworkExceptions? networkException) failure,
      required int pageKey,
      required String nameList}
      ) async {

    emit(
       loading(),
    );

    final response = await repository.getRequestBoxes(page: pageKey,nameList:nameList);

    response.when(
      success: (data) async {
        baseModel = data;
        requestBoxes?.listRequestBox.addAll(data.data.listRequestBox);
        if(requestBoxes?.listRequestBox.isEmpty??true) {
          emit(empty(data.message),);
        } else {
          emit(success(requestBoxes, data.message),);
        }
      },
      failure: (networkException) {

        emit(
          failure(networkException),
        );
        Constants.onNetworkFailure(context,networkException:networkException);
      },
    );
  }
  Future<void> getRequestBoxesImp(
      BuildContext context,
      String nameList  ///send || recived
      ) async {


    if(nameList!=currentNameList) {
      initRequestBox();
    }

    currentNameList=nameList;

    if (baseModel!=null&&baseModel?.meta?.to == null) return;

    int pageKey = (baseModel?.meta?.currentPage??0) + 1;
    first=false;
    if(pageKey<=1) {
      requestBoxes = RequestBoxes(listRequestBox: []);
      first=true;
    }
    getRequestBoxesBase(context,
        loading:()=>  first?const RequestBoxState.loadingFirst():const RequestBoxState.loadingPagination(),
        empty: (message)=> first?RequestBoxState.emptyFirst(message):RequestBoxState.emptyPagination(message),
        success: (data,message) =>first?RequestBoxState.successFirst(data,message):RequestBoxState.successPagination(data,message) ,
        failure: (networkException)=>first?RequestBoxState.failureFirst(networkException):RequestBoxState.failurePagination(networkException) ,
        pageKey: pageKey,
        nameList: nameList);
  }

  Future<void> getRequestBoxes(
      BuildContext context,
      String nameList  ///send || recived
      ) async {

    if(nameList!=currentNameList) {
      initRequestBox();
    }
    currentNameList=nameList;

    if (baseModel!=null&&baseModel?.meta?.to == null) return;
    emit(
      const RequestBoxState.loadingPagination(),
    );

    int pageKey = (baseModel?.meta?.currentPage??0) + 1;

    if(pageKey<=1) {
      requestBoxes=RequestBoxes(listRequestBox: []);
    }

    final response = await repository.getRequestBoxes(page: pageKey,nameList:nameList);

    response.when(
      success: (data) async {
        baseModel = data;
        requestBoxes?.listRequestBox.addAll(data.data.listRequestBox);
        if(requestBoxes?.listRequestBox.isEmpty??true) {
          emit(RequestBoxState.emptyPagination(data.message),);
        } else {
          emit(RequestBoxState.successPagination(requestBoxes, data.message),);
        }
      },
      failure: (networkException) {
        emit(
          RequestBoxState.failurePagination(networkException),
        );
        Constants.onNetworkFailure(context,networkException:networkException);

      },
    );
  }
  /// end old api

  Future<void> getSendRequestBoxes(
      BuildContext context,{required int? pageKey}
      ) async {
    if((pageKey??1)==1)sendRequestsBox.clear();
    emit(const RequestBoxState.loadingPagination(),);
    final response = await repository.getRequestBoxes(page:pageKey,nameList: 'send');
    response.when(
      success: (data) async {
        List list = data.data.listRequestBox;
        sendRequestsBox.addAll(list.whereType());
        pagingAdapterSend.handlePageData(baseModel:data,pageData: sendRequestsBox, pageKey: pageKey, pagingController: pagingAdapterSend.pagingController);
        emit(RequestBoxState.successPagination(null, data.message),);
      },
      failure: (networkException) {
        pagingAdapterSend.pagingController.error = networkException;
        emit(RequestBoxState.failurePagination(networkException),);
        Constants.onNetworkFailure(context,networkException:networkException);
      },
    );
  }
  Future<void> getRecRequestBoxes(
      BuildContext context,{required int? pageKey}
      ) async {
    if((pageKey??1)==1)recRequestsBox.clear();
    emit(const RequestBoxState.loadingPagination(),);
    final response = await repository.getRequestBoxes(page:pageKey,nameList: 'recived');
    response.when(
      success: (data) async {
        List list = data.data.listRequestBox;
        recRequestsBox.addAll(list.whereType());
        pagingAdapterRec.handlePageData(baseModel:data,pageData: recRequestsBox, pageKey: pageKey, pagingController: pagingAdapterRec.pagingController);
        emit(RequestBoxState.successPagination(null, data.message),);
      },
      failure: (networkException) {
        pagingAdapterRec.pagingController.error = networkException;
        emit(RequestBoxState.failurePagination(networkException),);
        Constants.onNetworkFailure(context,networkException:networkException);
      },
    );
  }



  Future<void> createRequestBox(
      BuildContext context,{
        required int? recivedId,
        required String title,
        required String? subTitle,
        required int? requestTypeId,
        required List<int>? fileIds,
      }
      ) async {
  Constants.loading(context);
    requestBox=RequestBox(title: title,recivedId: recivedId,subTitle: subTitle,requestTypeId: requestTypeId);
    final response = await repository.createRequestBox(requestBox:requestBox!,fileIds:fileIds//fileModels?.getFileIds()
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

  Future<void> uploadRequestFiles(
      BuildContext context,{
        required List<PlatformFile> files,
        InfoFile? infoFile,
      }
      ) async {
    final response = await repository.uploadRequestFiles(context,files:files,key:infoFile?.key);
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

  ///buildListSendBoxes
  bool buildListSendBoxesWhen(RequestBoxState previous,RequestBoxState current){
    if(current==previous) return false;
    return current.maybeWhen(
        loadingPagination: () =>true ,
        emptyPagination: (_) =>true ,
        successPagination: (_,__) =>true ,
        failurePagination: (_) =>true ,
        orElse: () =>false
    );
  }
  Widget buildListSendBoxes(BuildContext context,RequestBoxState state,Widget child)=>
      state.maybeWhen(
          loadingPagination:()=>const LoadingDataView(),
          emptyPagination:(message)=>EmptyDataView() ,
          failurePagination: (networkExceptions)=> ErrorView(networkExceptions:networkExceptions),
          orElse: () =>child
      );

  ///buildListSendBoxesFirst
  bool buildListSendBoxesFirstWhen(RequestBoxState previous,RequestBoxState current){
    if(current==previous) return false;
    return current.maybeWhen(
        loadingFirst: () =>true ,
        emptyFirst: (_) =>true ,
        successFirst: (_,__) =>true ,
        successPagination: (_,__) =>true ,
        failureFirst: (_) =>true ,
        orElse: () =>false
    );
  }
  Widget buildListSendBoxesFirst(
      BuildContext context,{
        required PagingController<int, RequestBox> pagingController,
        required Widget Function(BuildContext, RequestBox, int) itemBuilder})=>
      pagingAdapterSend.buildListView(context,
          pagingController,
          itemBuilder,
          loadBuilder:    const LoadList()
      );

  ///buildListSendBoxesPaginate
  bool buildListSendBoxesPaginateWhen(RequestBoxState previous,RequestBoxState current){
    if(current==previous) return false;
    return current.maybeWhen(
        loadingPagination: () =>true ,
        emptyPagination: (_) =>true ,
        successPagination: (_,__) =>true ,
        failurePagination: (_) =>true ,
        orElse: () =>false
    );
  }
  Widget buildListSendBoxesPaginate(BuildContext context,RequestBoxState state)=>
      state.maybeWhen(
          loadingPagination:()=>const LoadingDataView(),
          failurePagination: (networkExceptions)=> ErrorView(networkExceptions:networkExceptions),
        orElse: ()=>const SizedBox.shrink(),
      );

  ///buildMailBoxDetails
  bool buildMailBoxDetailsWhen(RequestBoxState previous,RequestBoxState current){
    if(current==previous) return false;
    return current.maybeWhen(
        loading: () =>true ,
        empty: (_) =>true ,
        success: (_,__) =>true ,
        failure: (_) =>true ,
        orElse: () =>false
    );
  }
  Widget buildMailBoxDetails(BuildContext context,RequestBoxState state,Widget child)=>

      state.maybeWhen(
          loading:()=>const LoadingDataView(),
          empty:(message)=>EmptyDataView() ,
          failure: (networkExceptions)=> ErrorView(networkExceptions:networkExceptions),
          orElse: () =>child
      );



  ///buildMailBoxPage
  bool buildMailBoxPageWhen(RequestBoxState previous,RequestBoxState current){
    if(current==previous) return false;
    return current.maybeWhen(
        loadingPage: () =>true ,
        successPage: (_,__) =>true ,
        failurePage: (_) =>true ,
        successPagination: (_,__) =>true ,
        orElse: () =>false
    );
  }
  Widget buildMailBoxPage(BuildContext context,RequestBoxState state,Widget child)=>
      state.maybeWhen(
          loadingPage:()=>const LoadingDataView(),
          failurePage: (networkExceptions)=> ErrorView(networkExceptions:networkExceptions),
          emptyPagination:(message)=>EmptyDataView() ,
          orElse: () =>child
      );

}
