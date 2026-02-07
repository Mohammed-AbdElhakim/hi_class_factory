import 'package:get_it/get_it.dart';

import '../../features/auth/data/repositories/login_repo_impl.dart';
import '../firebase/firebase_service.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<FirebaseService>(FirebaseService());
  getIt.registerSingleton<LoginRepoImpl>(LoginRepoImpl(getIt.get<FirebaseService>()));
}
