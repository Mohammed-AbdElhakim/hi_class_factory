import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/login_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase _loginUsecase;

  AuthBloc(this._loginUsecase) : super(const _Initial()) {
    on<LoginEvent>((event, emit) async {
      emit(const _Loading());
      try {
        final user = await _loginUsecase.execute(event.email, event.password);
        emit(_Authenticated(user));
      } catch (e) {
        emit(_Error(e.toString()));
      }
    });
  }
}
