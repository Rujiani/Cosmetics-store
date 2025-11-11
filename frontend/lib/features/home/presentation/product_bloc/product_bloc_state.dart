part of 'product_bloc_bloc.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class ProductLoadingState extends ProductState {}

final class ProductLoadedState extends ProductState {
  final List<Product> products;

  ProductLoadedState({required this.products});
}

final class ProductErrorState extends ProductState {
  final String error;

  ProductErrorState({required this.error});
}
