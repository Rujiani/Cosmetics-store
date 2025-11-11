part of 'product_bloc_bloc.dart';

@immutable
sealed class ProductEvent {}

final class LoadProductsEvent extends ProductEvent {}
