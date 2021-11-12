import 'package:get_it/get_it.dart';
import 'package:grojha/services/dynamic_link_service.dart';
import 'package:grojha/services/push_notification_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  // locator.registerLazySingleton(() => DialogService());
  // locator.registerLazySingleton(() => AuthenticationService());
  // locator.registerLazySingleton(() => FirestoreService());
  // locator.registerLazySingleton(() => CloudStorageService());
  // locator.registerLazySingleton(() => ImageSelector());
  locator.registerLazySingleton(() => PushNotificationService());
  // locator.registerLazySingleton(() => AnalyticsService());
  locator.registerLazySingleton(() => DynamicLinkService());
}
