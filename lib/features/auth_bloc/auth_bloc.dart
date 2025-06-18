import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth_event/auth_event.dart';
import '../repo/auth_repo.dart';
import '../auth_state/auth_state.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<UpdatePhone>((event, emit) {
      if (state is AuthInitial) {
        emit((state as AuthInitial).copyWith(phone: event.phone));
      }
    });

    on<UpdatePassword>((event, emit) {
      if (state is AuthInitial) {
        emit((state as AuthInitial).copyWith(password: event.password));
      }
    });

    on<UpdateConfirmPassword>((event, emit) {
      if (state is AuthInitial) {
        emit((state as AuthInitial).copyWith(confirmPassword: event.confirmPassword));
      }
    });

    on<TogglePasswordVisibility>((event, emit) {
      if (state is AuthInitial) {
        final current = state as AuthInitial;
        emit(current.copyWith(obscurePassword: !current.obscurePassword));
      }
    });

    on<ToggleConfirmPasswordVisibility>((event, emit) {
      if (state is AuthInitial) {
        final current = state as AuthInitial;
        emit(current.copyWith(obscureConfirmPassword: !current.obscureConfirmPassword));
      }
    });

    on<LoginSubmitted>((event, emit) async {
      emit(AuthLoading());
      try {
        await authRepository.loginUserByPhone(
          phoneNumber: event.phoneNumber,
          password: event.password,
        );
        emit(AuthSuccess());
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    on<SignupSubmitted>((event, emit) async {
      if (state is AuthInitial) {
        final current = state as AuthInitial;
        emit(SignupLoading());
        try {
          await authRepository.signup(
            phone: current.phone,
            password: current.password,
            confirmPassword: current.confirmPassword,
          );
          emit(SignupSuccess());
        } catch (e) {
          emit(SignupFailure(e.toString()));
        }
      }
    });
  }
}