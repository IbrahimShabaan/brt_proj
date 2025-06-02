import 'package:flutter_bloc/flutter_bloc.dart';
import '../auth_repo.dart';
import '../auth_event/auth_event.dart';
import '../auth_state/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository)
      : super(AuthInitial()) {
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

// auth_bloc.dart
    on<LoginSubmitted>((event, emit) async {
      emit(AuthLoading());
      try {
        final response = await authRepository.loginUserByPhone(
          phoneNumber: event.phoneNumber,
          password: event.password,
        );
        if (response.statusCode == 200) {
          emit(AuthSuccess());
        } else {
          emit(AuthFailure('Login failed'));
        }
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    on<UpdateConfirmPassword>((event, emit) {
      if (state is AuthInitial) {
        emit((state as AuthInitial).copyWith(confirmPassword: event.confirmPassword));
      }
    });

    on<TogglePasswordVisibility>((event, emit) {
      if (state is AuthInitial) {
        final currentState = state as AuthInitial;
        emit(currentState.copyWith(obscurePassword: !currentState.obscurePassword));
      }
    });

    on<ToggleConfirmPasswordVisibility>((event, emit) {
      if (state is AuthInitial) {
        final currentState = state as AuthInitial;
        emit(currentState.copyWith(obscureConfirmPassword: !currentState.obscureConfirmPassword));
      }
    });

    on<SignupSubmitted>((event, emit) async {
      if (state is AuthInitial) {
        final currentState = state as AuthInitial;
        emit(SignupLoading());
        try {
          await authRepository.signup(
            phone: currentState.phone,
            password: currentState.password,
            confirmPassword: currentState.confirmPassword,
          );
          emit(SignupSuccess());
        } catch (e) {
          emit(SignupFailure(e.toString()));
        }
      }
    });



  }
}