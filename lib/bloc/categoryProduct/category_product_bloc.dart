import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/categoryProduct/category_product_event.dart';
import 'package:shop_app/bloc/categoryProduct/category_product_state.dart';
import 'package:shop_app/data/repository/category_Product_repository.dart';

import '../../di/di.dart';

class CategoryProductBloc
    extends Bloc<CategoryProductEvent, CategoryProductState> {
  final ICategoryProductRepository categoryproductRepository = locator.get();
  CategoryProductBloc() : super(CategoryProductLoadingState()) {
    on<CategoryProductInitialize>((event, emit) async {
      var response = await categoryproductRepository
          .getProductByCategoryId(event.categoryId);
      emit(CategoryProductResponseSuccessState(response));
    });
  }
}
