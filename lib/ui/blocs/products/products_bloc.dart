import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:clima_link/api/api.dart';
import 'package:clima_link/data/data.dart';
import 'package:clima_link/domain/usecases/products_usecase.dart';

part 'products_bloc_handler.dart';
part 'products_event.dart';
part 'products_state.dart';

/// Manages product-related events and states.
///
/// Uses a [ProductsUseCase] to interact with product data
class ProductsBloc extends Bloc<ProductsEvent, ProductsState>
    with ProductsBlocHandler {
  /// The use case for product operations.
  final ProductsUseCase useCase;

  /// Creates a [ProductsBloc].
  ///
  /// Requires a [ProductsUseCase].
  ///
  ProductsBloc(this.useCase) : super(ProductsState()) {
    on<LoadProductsEvent>(handlerLoadProducts);
  }

  /// Triggers the loading of products.
  ///
  /// Adds a [LoadProductsEvent] to the bloc.
  void loadProducts() {
    add(LoadProductsEvent());
  }
}
