part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}
final class HomeLoading extends HomeState {}
final class HomeSuccess extends HomeState {
  final List<ProductsModel> products;
  final List<String> categories;
  HomeSuccess({required this.products, required this.categories});
}
final class HomeFailure extends HomeState {
  final String errMsg;
  HomeFailure(this.errMsg);
}
