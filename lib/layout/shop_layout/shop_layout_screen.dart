import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/cart/cart_screen.dart';
import 'package:shop_app/shared/styles/icon_broken.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import '../../modules/categoies/categories_screen.dart';
import '../../modules/cubit/cubit.dart';
import '../../modules/cubit/states.dart';
import '../../modules/favorits/favorits_screen.dart';
import '../../modules/products/products_screen.dart';
import '../../modules/search/search_screen.dart';
import '../../modules/settings/settings_screen.dart';
import '../../shared/components/components.dart';


class ShopLayoutScreen extends StatelessWidget {
  const ShopLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit=ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title:  Text(
                cubit.titles[cubit.currentIndex]
            ),
            actions: [
              IconButton(
                  onPressed: (){
                    navigateTo(context, const SearchScreen());
                  },
                  icon: const Icon(IconBroken.Search)),
              IconButton(
                  onPressed: (){
                    navigateTo(context, const CartScreen());
                  },
                  icon: const Icon(
                      //Icons.shopping_cart
                    IconBroken.Buy
                  )
              ),
            ],
          ),
          body:PageView(
            controller: cubit.pageController,
            onPageChanged: (index){
              cubit.changeBottom(index);
            },
            scrollDirection: Axis.horizontal,
            children: const [
              ProductsScreen(),
              CategoriesScreen(),
              FavoritesScreen(),
              SettingsScreen(),
              //cubit.bottomScreens[cubit.currentIndex],
            ],
          ),
          bottomNavigationBar:CurvedNavigationBar(
            items: const <Widget>[
              Icon(IconBroken.Home),
              Icon(IconBroken.Category),
              Icon(IconBroken.Heart),
              Icon(IconBroken.Setting),
            ],
            index: cubit.currentIndex,
            height: 60.0,
            color: Colors.black26,
            buttonBackgroundColor: Colors.white,
            backgroundColor: Colors.white,
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(milliseconds: 600),
            onTap: (index) {
              cubit.pageController.animateToPage(index, duration: const Duration(milliseconds: 600), curve: Curves.easeInOut,);
              cubit.changeBottom(index);
            },
            letIndexChange: (index) => true,
          ),
        );
      },
    );
  }
}
