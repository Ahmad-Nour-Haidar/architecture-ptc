part of 'request_box_cubit.dart';

@freezed
class RequestBoxState  with _$RequestBoxState {
  const factory RequestBoxState.initial() = _Initial;
  const factory RequestBoxState.dispose() = _Dispose;
  const factory RequestBoxState.save() = _Save;
  const factory RequestBoxState.loading() = _Loading;
  const factory RequestBoxState.failure(NetworkExceptions? networkException) = _Failure;
  const factory RequestBoxState.success(RequestBox? data,String? message) = _Success;
  const factory RequestBoxState.empty(String? message) = _Empty;

  const factory RequestBoxState.loadingPage() = _LoadingPage;
  const factory RequestBoxState.failurePage(NetworkExceptions? networkException) = _FailurePage;
  const factory RequestBoxState.successPage(InfoBox? data,String? message) = _SuccessPage;
  const factory RequestBoxState.emptyPage(String? message) = _EmptyPage;

  const factory RequestBoxState.loadingPagination() = _LoadingPagination;
  const factory RequestBoxState.emptyPagination(String? message) = _EmptyPagination;
  const factory RequestBoxState.failurePagination(NetworkExceptions? networkException) = _FailurePagination;
  const factory RequestBoxState.successPagination(RequestBoxes? data,String? message) = _SuccessPagination;

  const factory RequestBoxState.loadingFirst() = _LoadingFirst;
  const factory RequestBoxState.emptyFirst(String? message) = _EmptyFirst;
  const factory RequestBoxState.failureFirst(NetworkExceptions? networkException) = _FailureFirst;
  const factory RequestBoxState.successFirst(RequestBoxes? data,String? message) = _SuccessFirst;

}

