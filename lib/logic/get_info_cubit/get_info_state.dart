part of 'get_info_cubit.dart';

@freezed
class GetInfoState with _$GetInfoState {
  const factory GetInfoState.loading() = _Loading;
  const factory GetInfoState.error(String error) = _Error;
  const factory GetInfoState.success(List<InfoModel> model) = _Success;
}
