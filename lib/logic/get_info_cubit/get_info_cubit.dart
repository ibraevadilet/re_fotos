import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:re_fotos/logic/model/info_model.dart';

part 'get_info_state.dart';
part 'get_info_cubit.freezed.dart';

class GetInfoCubit extends Cubit<GetInfoState> {
  GetInfoCubit() : super(const GetInfoState.loading()) {
    getInfo();
  }

  Future<void> getInfo() async {
    try {
      final pictures = await getInfoFromServer();
      emit(GetInfoState.success(pictures));
    } catch (e) {
      emit(GetInfoState.error(e.toString()));
    }
  }

  Future<List<InfoModel>> getInfoFromServer() async {
    final snapshot =
        await FirebaseDatabase.instance.ref('retouch_lifehacks').get();

    final lessonsFromServer = <InfoModel>[];
    if (snapshot.value != null) {
      final map = snapshot.value as Map<dynamic, dynamic>;

      map.forEach((key, value) {
        value['id'] = key;
        final lesson = InfoModel.fromJson(value);

        lessonsFromServer.add(lesson);
      });
    }

    return lessonsFromServer;
  }
}
