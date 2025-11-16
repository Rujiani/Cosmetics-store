part of 'product_bloc_bloc.dart';

@immutable
sealed class ProductEvent {}

final class LoadAllProductsEvent extends ProductEvent {}
