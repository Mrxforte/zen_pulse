import 'package:get_it/get_it.dart';
import 'package:zen_pulse/services/mock_api_service.dart';

final GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  if (!serviceLocator.isRegistered<MockApiService>()) {
    serviceLocator.registerLazySingleton<MockApiService>(
      () => MockApiService(),
    );
  }
}
