import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:app3/core/resources/app_colors.dart';
import 'package:app3/core/resources/app_field.dart';
import 'package:app3/core/resources/app_icons.dart';
import 'package:app3/core/resources/app_images.dart';
import 'package:app3/core/resources/app_loader.dart';
import 'package:app3/core/resources/snack_bar.dart';
import 'package:app3/features/details/details_screen.dart';
import 'package:app3/features/home/home_cubit.dart';
import 'package:app3/features/home/widgets/categories.dart';
import 'package:app3/features/home/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getHomeData(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            print("========================$state===================");
            if (state is HomeFailure) {
              showMySnackBar(
                msg: state.errMsg,
                type: AnimatedSnackBarType.error,
                context: context,
              );
            }
          },

          builder: (context, state) {
            if (state is HomeLoading) {
              return AppLoader();
            }
            if (state is HomeSuccess) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Discover",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -1,
                          color: AppColors.textColor,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: AppField(
                              hint: "Search...",
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  right: 10,
                                ),
                                child: SvgPicture.asset(
                                  AppIcons.search,
                                  width: 15,
                                  height: 15,
                                  colorFilter: ColorFilter.mode(
                                    AppColors.hintColor,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: SizedBox(
                              width: 56,
                              height: 56,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.mainColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 0,
                                  padding: EdgeInsets.zero,
                                ),
                                child: SvgPicture.asset(
                                  AppIcons.filter,
                                  width: 25,
                                  height: 25,
                                  colorFilter: const ColorFilter.mode(
                                    Colors.white,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      CategoriesTabs(categories: state.categories),
                      const SizedBox(height: 16),
                      Expanded(
                        child: GridView.builder(
                          itemCount: state.products.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 20,
                                childAspectRatio: 0.8,
                              ),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => DetailsScreen(
                                      id: state.products[index].id!,
                                    ),
                                  ),
                                );
                              },
                              child: ProductItem(
                                imageUrl: state.products[index].image ?? "",
                                title: state.products[index].title ?? "",
                                price: "\$ ${state.products[index].price}",
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
