import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';

import '../../models/shop_app/categories_model.dart';
import '../../models/shop_app/change_favorites_model.dart';
import '../../models/shop_app/favorites_model.dart';
import '../../models/shop_app/home_model.dart';
import '../../models/shop_app/login_model.dart';
import '../../shared/components/constants.dart';
import '../../shared/networks/end_points.dart';
import '../../shared/networks/remote/dio_helper.dart';
import '../categoies/categories_screen.dart';
import '../favorits/favorits_screen.dart';
import '../products/products_screen.dart';
import '../settings/settings_screen.dart';


class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());
  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  PageController pageController=PageController(initialPage: 0);
  List<Widget> bottomScreens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    const SettingsScreen(),
  ];
  List<String> titles = [
    'Home',
    'Categories',
    'Favorites',
    'Settings',
  ];

  bool isFav=false;

  void changeBottom(int index) {
    currentIndex = index;

    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      for (var element in homeModel!.data.products) {
        favorites.addAll({
          element.id: element.inFavorites,
        });
      }
      //print(favorites.toString());

      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ShopErrorHomeDataState(error: error.toString()));
    });
  }

  CategoriesModel? categoriesModel;
  void getCategoriesData() {
    DioHelper.getData(
      url: GET_CATEGORIES,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ShopErrorCategoriesState(error: error.toString()));
    });
  }

  late ChangeFavoritesModel changeFavoritesModel;

  void changeFavorites({required int productId}) {
    favorites[productId] = !favorites[productId]!;
    emit(ShopFavoritesState());
    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      //print(value.data);
      if (!changeFavoritesModel.status) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavorites();
      }
      emit(ShopSuccessFavoritesState(changeFavoritesModel));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;
      showToast(text: error.toString(), state: ToastStates.ERROR);
      emit(ShopErrorFavoritesState());
    });
  }

  FavoritesModel? favoritesModel;
  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ShopErrorGetFavoritesState(error: error.toString()));
    });
  }

  ShopLoginModel? userDataModel;
  void getUserData() {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userDataModel = ShopLoginModel.fromJson(value.data);
      //print(value.data.toString());

      emit(ShopSuccessUserDataState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ShopErrorUserDataState(error: error.toString()));
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopLoadingUpdateUserState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      userDataModel = ShopLoginModel.fromJson(value.data);
      //print(value.data.toString());
      emit(ShopSuccessUpdateUserState());
      showToast(text: 'Update Successfully', state: ToastStates.SUCCESS);
    }).catchError((error) {
      showToast(text: error.toString(), state: ToastStates.ERROR);
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ShopErrorUpdateUserState(error: error.toString()));
    });
  }

  List<ProductsModel>? cartItems=[];
  void addToCart(ProductsModel model)
  {
    cartItems!.add(model);
    emit(ShopSuccessAddItemToCartState());
  }
  void removeFromCart(int index){
    cartItems!.removeAt(index);
    emit(ShopSuccessRemoveItemFromCartState());
    calcTotal();
  }

  num price=0;
   void calcTotal(){
     price=0;
    cartItems?.forEach((element) {
      price=price+element.price;
    });
    emit(ShopSuccessCalcTotalState());
  }

}
