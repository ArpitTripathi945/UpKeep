import 'package:upkeep/services/auth_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.I;

void setUpLocater() {
  locator.registerLazySingleton(() => AuthService());
}
