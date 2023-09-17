import 'package:bloc/bloc.dart';
import 'package:shop_app/bloc/category/category_event.dart';
import 'package:shop_app/bloc/category/category_state.dart';
import 'package:shop_app/data/repository/category_repository.dart';
import 'package:shop_app/di/di.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitState()) {
    final ICategoryRepository _repository = locator.get();
    on<CategoryRequestList>((event, emit) async {
      emit(CategoryLoadingState());
      var response = await _repository.getCategories();
      emit(CategoryResponseState(response));
    });
  }
}
