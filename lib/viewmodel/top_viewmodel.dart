import 'package:homework_master/main.dart';
import 'package:homework_master/service/shared_preferences_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TopViewModel {
  final sharedPreferencesService = getIt<SharedPreferencesService>();

  Future<bool> isFirstLaunch() async {
    final username = await sharedPreferencesService.getUsername();
    return username == null ? true : false;
  }
}

final topViewModelProvider = Provider((ref) => TopViewModel());
