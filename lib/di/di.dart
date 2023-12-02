import 'package:get_it/get_it.dart';
import 'package:test_2/presentation/dashboard/bloc/dashboard_bloc.dart';

final locator = GetIt.instance;

setupDI() async {
  locator.registerLazySingleton<DashboardBloc>(() => DashboardBloc());

  // locator.registerLazySingleton<DashboardBloc>(() => DashboardBloc(
  //     sharedPreferences: locator<SharedPreferences>(),
  //     api: locator<ApiServices>()));
}
