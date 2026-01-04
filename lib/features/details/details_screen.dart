import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:app3/core/resources/app_button.dart';
import 'package:app3/core/resources/app_colors.dart';
import 'package:app3/core/resources/app_icons.dart';
import 'package:app3/core/resources/app_loader.dart';
import 'package:app3/core/resources/snack_bar.dart';
import 'package:app3/features/details/details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailsScreen extends StatelessWidget {
  final int id;
  const DetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailsCubit()..getProductDetails(id),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text("Details", style: TextStyle(color: AppColors.textColor)),
          centerTitle: true,
          leading: GestureDetector(
            child: const Icon(Icons.arrow_back_ios, color: AppColors.textColor),
            onTap: () {
              Navigator.of(context).pop(context);
            },
          ),
        ),
        body: BlocConsumer<DetailsCubit, DetailsState>(
          listener: (context, state) {
            print("=================$state============");
            if (state is DetailsFailure) {
              showMySnackBar(
                msg: state.errMsg,
                type: AnimatedSnackBarType.error,
                context: context,
              );
            }
          },
          builder: (context, state) {
            if (state is DetailsLoading) {
              return AppLoader();
            }
            if (state is DetailsSuccess) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 16.0,
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Center(
                                child: Image.network(
                                  state.model.image ?? "image url",
                                  width: 342,
                                  height: 300,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                state.model.title ?? "Product Title",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textColor,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  SvgPicture.asset(AppIcons.star),
                                  const SizedBox(width: 6),
                                  Text(
                                    "4.0/5",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.textColor,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    "(45 reviews)",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: AppColors.hintColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 13),
                              Text(
                                state.model.description ??
                                    "Product description",
                                style: TextStyle(
                                  color: AppColors.hintColor,
                                  fontSize: 16,
                                  height: 1.6,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Divider(color: Color(0xffE6E6E6), thickness: 1),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                "Price",
                                style: TextStyle(color: AppColors.hintColor),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "\$${state.model.price}",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 24),
                          Expanded(
                            child: AppButton(
                              onPressed: () {},
                              color: AppColors.mainColor,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    AppIcons.cart,
                                    colorFilter: const ColorFilter.mode(
                                      Colors.white,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    "Add to Cart",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}
