import 'package:get_it/get_it.dart';
import 'package:test_2/data/dataSources/player_data.dart';
import 'package:test_2/presentation/dashboard/bloc/dashboard_bloc.dart';

final locator = GetIt.instance;

setupDI() async {
  locator.registerSingleton(PlayerDataSqfliteDBClass());
  locator.registerLazySingleton<DashboardBloc>(() => DashboardBloc(localDb: locator.get<PlayerDataSqfliteDBClass>()));

  // locator.registerLazySingleton<DashboardBloc>(() => DashboardBloc(
  //     sharedPreferences: locator<SharedPreferences>(),
  //     api: locator<ApiServices>()));
}
