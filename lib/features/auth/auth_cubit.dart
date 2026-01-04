import 'package:app3/core/network/dio_helper.dart';
import 'package:app3/core/network/end_points.dart';
import 'package:app3/core/resources/cache_helper.dart';
import 'package:app3/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> login({
    required String username,
    required String password,
  }) async {
    if (username.isEmpty || password.isEmpty) {
      emit(LoginFailure("Please fill form fields!"));
      return;
    }

    emit(LoginLoading());

    try {
      final response = await DioHelper.postRequest(
        endPoint: EndPoints.login,
        data: {"username": username, "password": password},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final model = UserModel.fromJson(response.data);

        if (model.token == null) {
          emit(LoginFailure("No token found!"));
          return;
        }

        await CacheHelper.saveToken(model.token!);
        emit(LoginSuccess());
      }
    } on DioException catch (e) {
      emit(LoginFailure(e.message ?? "Login failed"));
    }
  }

  Future<void> signUp({
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    if (username.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      emit(SignUpFailure("Please fill form fields!"));
      return;
    }

    if (password != confirmPassword) {
      emit(SignUpFailure("Password does not match"));
      return;
    }

    emit(SignUpLoading());

    try {
      final response = await DioHelper.postRequest(
        endPoint: EndPoints.signup,
        data: {"username": username, "email": email, "password": password},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(SignUpSuccess());
      } else {
        emit(SignUpFailure("Sign up failed"));
      }
    } on DioException catch (e) {
      emit(SignUpFailure(e.message ?? "Error"));
    }
  }
}
