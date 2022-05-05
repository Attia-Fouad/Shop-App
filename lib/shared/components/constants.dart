
import '../../modules/login/shop_login-screen.dart';
import '../networks/local/cache_helper.dart';
import 'components.dart';
/*
base (url):https://newsapi.org/
method :v2/top-headlines?
queries :country=eg&category=business&apiKey=65f7f556ec76449fa7dc7c0069f040ca

https://www.getpostman.com/collections/3223d639447a8524e38f

https://newsapi.org/v2/everything?q=tesla&apiKey=65f7f556ec76449fa7dc7c0069f040ca
 */
void signOut(context) {
  showToast(text: 'Logout Successfully', state: ToastStates.WARNING);
  CacheHelper.removeData(key: 'token').then((value) {
    if (value) navigateAndFinish(context, const ShopLoginScreen());
  });
}

String? token;

