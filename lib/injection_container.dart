import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/util/api_basehelper.dart';
import 'features/currencies/currencies_inject.dart';

final GetIt sl = GetIt.instance;

abstract class ServiceLocator {
  static Future<void> init() async {
    sl.allowReassignment = true;

    await _injectSharedPreferences();
    // features
    currenciesServiceLocator();
    // core
    _injectDioHelper();
  }
}

void _injectDioHelper() {
  final ApiBaseHelper helper = ApiBaseHelper();
  helper.dioInit();
  sl.registerLazySingleton<ApiBaseHelper>(() => helper);
}

Future<void> _injectSharedPreferences() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => prefs);
}

SharedPreferences get sharedPreferences => sl<SharedPreferences>();

ApiBaseHelper get dioHelper => sl<ApiBaseHelper>();
