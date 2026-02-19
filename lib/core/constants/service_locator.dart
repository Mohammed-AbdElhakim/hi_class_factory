import 'package:get_it/get_it.dart';

import '../../features/accessories/data/repositories/accessories_repo_impl.dart';
import '../../features/auth/data/repositories/login_repo_impl.dart';
import '../../features/bakr/data/repositories/bakr_repo_impl.dart';
import '../../features/finishedProducts/data/repositories/finished_products_repo_impl.dart';
import '../firebase/firebase_service.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<FirebaseService>(FirebaseService());
  getIt.registerSingleton<LoginRepoImpl>(LoginRepoImpl(getIt.get<FirebaseService>()));
  getIt.registerSingleton<FinishedProductsRepoImpl>(
    FinishedProductsRepoImpl(getIt.get<FirebaseService>()),
  );
  getIt.registerSingleton<AccessoriesRepoImpl>(
    AccessoriesRepoImpl(getIt.get<FirebaseService>()),
  );
  getIt.registerSingleton<BakrRepoImpl>(BakrRepoImpl(getIt.get<FirebaseService>()));
}
