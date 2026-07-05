import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/home_data.dart';
import '../../domain/usecases/get_home_data_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetHomeDataUsecase _getHomeDataUsecase;

  HomeBloc(this._getHomeDataUsecase) : super(const HomeState.initial()) {
    on<_FetchData>((event, emit) async {
      emit(const HomeState.loading());
      try {
        final data = await _getHomeDataUsecase.execute();
        emit(HomeState.loaded(data));
      } catch (e) {
        emit(HomeState.error(e.toString()));
      }
    });
  }
}
