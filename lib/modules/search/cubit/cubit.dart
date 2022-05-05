import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/cubit/states.dart';

import '../../../models/shop_app/search_model.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/networks/end_points.dart';
import '../../../shared/networks/remote/dio_helper.dart';

class ShopSearchCubit extends Cubit<SearchStates> {
  ShopSearchCubit() : super(SearchInitialState());

  static ShopSearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;

  void search(String text) {
    emit(SearchLoadingState());

    DioHelper.postData(
      url: SEARCH,
      token: token,
      data: {
        'text': text,
      },
    ).then((value) {
      model = SearchModel.fromJson(value.data);

      emit(SearchSuccessState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }

      emit(SearchErrorState());
    });
  }
}
