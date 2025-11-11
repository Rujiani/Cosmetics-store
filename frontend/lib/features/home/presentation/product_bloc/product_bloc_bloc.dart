import 'package:bloc/bloc.dart';
import 'package:cosmetics_store/core/api/api_client.dart';
import 'package:cosmetics_store/core/widgets/products/product_entity.dart';
import 'package:meta/meta.dart';

part 'product_bloc_event.dart';
part 'product_bloc_state.dart';

// lib/features/products/presentation/blocs/product_bloc/product_bloc.dart
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ApiClient apiClient;

  ProductBloc(this.apiClient) : super(ProductInitial()) {
    on<LoadProductsEvent>(_onLoadProducts);
  }

  void _onLoadProducts(
    LoadProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoadingState());
    try {
      final products = await apiClient.getProducts();
      emit(ProductLoadedState(products: products));
    } catch (e) {
      emit(ProductErrorState(error: e.toString()));
    }
  }
}
