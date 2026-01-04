import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:app3/core/resources/app_colors.dart';
import 'package:app3/core/resources/app_loader.dart';
import 'package:app3/core/resources/snack_bar.dart';
import 'package:app3/features/auth/auth_cubit.dart';
import 'package:app3/features/auth/login/login_screen.dart';
import 'package:app3/core/resources/app_field.dart';
import 'package:app3/features/auth/widgets/custom_password_field.dart';
import 'package:app3/core/resources/app_button.dart';
import 'package:app3/features/home_navigation/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),

      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            print("=============$state=================");
            if (state is SignUpFailure) {
              showMySnackBar(
                msg: state.msg,
                type: AnimatedSnackBarType.error,
                context: context,
              );
            }
            if (state is SignUpSuccess) {
              showMySnackBar(
                msg: "Sign Up Successfully!!",
                type: AnimatedSnackBarType.success,
                context: context,
              );
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => HomeNav()),
              );
            }
          },
          builder: (context, state) {
            final cubit = context.read<AuthCubit>();
            if (state is SignUpLoading) {
              return AppLoader();
            }

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
                            "Create an account",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                              letterSpacing: -1,
                              color: AppColors.textColor,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "Let’s create your account.",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0,
                              color: AppColors.hintColor,
                            ),
                          ),
                          const SizedBox(height: 24),
                          AppField(
                            label: "User Name",
                            hint: "Enter your username",
                            controller: userNameController,
                          ),
                          const SizedBox(height: 16),
                          AppField(
                            label: "Email",
                            hint: "Enter your email address",
                            controller: emailController,
                          ),
                          const SizedBox(height: 16),
                          CustomPasswordField(
                            label: "Password",
                            hint: "Enter your password",
                            controller: passwordController,
                          ),
                          const SizedBox(height: 16),
                          CustomPasswordField(
                            label: "Confirm Password",
                            hint: "Enter your password",
                            controller: confirmPasswordController,
                          ),
                          const SizedBox(height: 55),
                          AppButton(
                            color: AppColors.mainColor,
                            child: Text(
                              "Create Account",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            onPressed: () {
                              cubit.signUp(
                                username: userNameController.text.trim(),
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                                confirmPassword: confirmPasswordController.text
                                    .trim(),
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
                        "Already have an account? ",
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.hintColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "Log In",
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
