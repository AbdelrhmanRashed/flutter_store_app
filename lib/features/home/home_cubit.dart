import 'package:app3/core/network/dio_helper.dart';
import 'package:app3/core/network/end_points.dart';
import 'package:app3/models/products_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  Future<void> getHomeData() async {
    try {
      emit(HomeLoading());

      final responses = await Future.wait([
        DioHelper.getRequest(endPoint: EndPoints.products),
        DioHelper.getRequest(endPoint: EndPoints.categories),
      ]);

      final productsResponse = responses[0];
      final categoriesResponse = responses[1];

      if ((productsResponse.statusCode == 200 &&
              categoriesResponse.statusCode == 200) ||
          (productsResponse.statusCode == 201 &&
              categoriesResponse.statusCode == 201)) {
        final products = (productsResponse.data as List)
            .map((product) => ProductsModel.fromJson(product))
            .toList();

        final categories = List<String>.from(categoriesResponse.data);

        emit(HomeSuccess(products: products, categories: categories));
      } else {
        emit(HomeFailure("Failed to load data"));
      }
    } on DioException catch (e) {
      emit(HomeFailure(e.message ?? "Network error"));
    }
  }
}
