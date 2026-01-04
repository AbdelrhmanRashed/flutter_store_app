import 'package:app3/core/network/dio_helper.dart';
import 'package:app3/core/network/end_points.dart';
import 'package:app3/models/products_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit() : super(DetailsInitial());

  Future<void> getProductDetails(int id) async {
    try {
      emit(DetailsLoading());
      Response response = await DioHelper.getRequest(
        endPoint: EndPoints.productDetails + id.toString(),
      );


      if(response.statusCode == 200 || response.statusCode == 201) {
        final product =
        ProductsModel.fromJson(response.data as Map<String, dynamic>);

        emit(DetailsSuccess(product));
      }
    } on DioException catch (e) {
      emit(DetailsFailure(e.message ?? "Error to get product details"));
    }
  }
}
