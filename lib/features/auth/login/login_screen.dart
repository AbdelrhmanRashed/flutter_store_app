import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:app3/core/resources/app_colors.dart';
import 'package:app3/core/resources/app_loader.dart';
import 'package:app3/core/resources/snack_bar.dart';
import 'package:app3/features/auth/auth_cubit.dart';
import 'package:app3/features/auth/signup/signup_screen.dart';
import 'package:app3/core/resources/app_field.dart';
import 'package:app3/features/auth/widgets/custom_password_field.dart';
import 'package:app3/core/resources/app_button.dart';
import 'package:app3/features/home_navigation/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            print("=============$state=================");
            if (state is LoginFailure) {
              showMySnackBar(
                msg: state.msg,
                type: AnimatedSnackBarType.error,
                context: context,
              );
            }
            if (state is LoginSuccess) {
              showMySnackBar(
                msg: "Logging Successfully!",
                type: AnimatedSnackBarType.success,
                context: context,
              );
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => HomeNav()),
              );
            }
          },
          builder: (context, state) {
            if (state is LoginLoading) {
              return AppLoader();
            }
            final cubit = context.read<AuthCubit>();

            return SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Login to your account",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                              letterSpacing: -1,
                              color: AppColors.textColor,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "It’s great to see you again.",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0,
                              color: AppColors.hintColor,
                            ),
                          ),
                          const SizedBox(height: 24),
                          AppField(
                            hint: "Enter your email address",
                            label: "User Name",
                            controller: userNameController,
                          ),
                          const SizedBox(height: 16),
                          CustomPasswordField(
                            hint: "Enter your password",
                            label: "Password",
                            controller: passwordController,
                          ),
                          const SizedBox(height: 55),
                          AppButton(
                            color: AppColors.mainColor,
                            child: Text(
                              "Sign in",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            onPressed: () {
                              cubit.login(
                                username: userNameController.text.trim(),
                                password: passwordController.text.trim(),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don’t have an account? ",
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.hintColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SignupScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "Join",
                          style: TextStyle(
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.textColor,
                            color: AppColors.textColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
