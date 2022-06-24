
import '../../models/shop_app/change_favorites_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {
  String? error;
  ShopErrorHomeDataState({this.error});
}

class ShopSuccessCategoriesState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates {
  String? error;
  ShopErrorCategoriesState({this.error});
}

class ShopSuccessFavoritesState extends ShopStates {
  final ChangeFavoritesModel model;
  ShopSuccessFavoritesState(this.model);
}

class ShopFavoritesState extends ShopStates {}

class AppChangeModeState extends ShopStates {}

class ShopErrorFavoritesState extends ShopStates {
  String? error;
  ShopErrorFavoritesState({this.error});
}

class ShopLoadingGetFavoritesState extends ShopStates {}

class ShopSuccessGetFavoritesState extends ShopStates {}

class ShopErrorGetFavoritesState extends ShopStates {
  String? error;
  ShopErrorGetFavoritesState({this.error});
}

class ShopLoadingUserDataState extends ShopStates {}

class ShopSuccessUserDataState extends ShopStates {}

class ShopErrorUserDataState extends ShopStates {
  String? error;
  ShopErrorUserDataState({this.error});
}

class ShopLoadingUpdateUserState extends ShopStates {}

class ShopSuccessUpdateUserState extends ShopStates {}

class ShopErrorUpdateUserState extends ShopStates {
  String? error;
  ShopErrorUpdateUserState({this.error});
}

class ShopSuccessAddItemToCartState extends ShopStates {}
class ShopSuccessRemoveItemFromCartState extends ShopStates {}
class ShopSuccessCalcTotalState extends ShopStates {}

