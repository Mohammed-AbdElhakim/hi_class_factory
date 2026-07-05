import 'package:injectable/injectable.dart';
import '../entities/home_data.dart';
import '../repositories/home_repository.dart';

@lazySingleton
class GetHomeDataUsecase {
  final HomeRepository _repository;

  GetHomeDataUsecase(this._repository);

  Future<HomeData> execute() async {
    return await _repository.getHomeData();
  }
}
