part of 'recive_request_box_cubit.dart';

@freezed
class ReciveRequestBoxState with _$ReciveRequestBoxState{
  const factory ReciveRequestBoxState.initial() = _Initial;
  const factory ReciveRequestBoxState.dispose() = _Dispose;
  const factory ReciveRequestBoxState.save() = _Save;
  const factory ReciveRequestBoxState.loading() = _Loading;
  const factory ReciveRequestBoxState.failure(NetworkExceptions? networkException) = _Failure;
  const factory ReciveRequestBoxState.success(RequestBox? data,String? message) = _Success;


  const factory ReciveRequestBoxState.loadingPagination() = _LoadingPagination;
  const factory ReciveRequestBoxState.emptyPagination(String? message) = _EmptyPagination;
  const factory ReciveRequestBoxState.failurePagination(NetworkExceptions? networkException) = _FailurePagination;
  const factory ReciveRequestBoxState.successPagination(RequestBoxes? data,String? message) = _SuccessPagination;

}

