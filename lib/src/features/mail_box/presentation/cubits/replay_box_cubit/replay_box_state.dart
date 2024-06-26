part of 'replay_box_cubit.dart';

@freezed
class ReplayBoxState with _$ReplayBoxState{
  const factory ReplayBoxState.initial() = _Initial;
  const factory ReplayBoxState.dispose() = _Dispose;
  const factory ReplayBoxState.save() = _Save;
  const factory ReplayBoxState.loading() = _Loading;
  const factory ReplayBoxState.failure(NetworkExceptions? networkException) = _Failure;
  const factory ReplayBoxState.success(ReplayBox? data,String? message) = _Success;


  const factory ReplayBoxState.loadingPagination() = _LoadingPagination;
  const factory ReplayBoxState.failurePagination(NetworkExceptions? networkException) = _FailurePagination;
  const factory ReplayBoxState.successPagination(ReplayBoxes? data,String? message) = _SuccessPagination;

}

