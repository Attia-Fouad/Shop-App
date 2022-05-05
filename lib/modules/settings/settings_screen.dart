import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:shop_app/modules/cart/cart_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/styles/icon_broken.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';
import '../edit/edit_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => ShopCubit()..getUserData(),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Conditional.single(
            context: context,
            conditionBuilder: (BuildContext context) => ShopCubit.get(context).userDataModel!=null,
            widgetBuilder: (BuildContext context) {
              var model = ShopCubit.get(context).userDataModel;
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 63,
                          backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                          child: const CircleAvatar(
                            radius: 60.0,
                            backgroundImage: NetworkImage(
                              'https://cdn3.iconfinder.com/data/icons/business-avatar-1/512/10_avatar-512.png',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                          child: Text(
                            '${model!.data!.name?.toUpperCase()}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                              fontSize: 18,
                            ),
                          )),
                      const SizedBox(
                        height: 50,
                      ),
                      InkWell(
                        onTap: () {
                          navigateTo(context, const EditScreen());
                        },
                        child: Container(
                          width: double.infinity,
                          height: 45,
                          decoration: BoxDecoration(
                            color: Colors.black38,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: const [
                                Icon(IconBroken.Edit),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Edit Profile',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Spacer(),
                                Icon(Icons.arrow_forward_ios),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      InkWell(
                        onTap: () {
                          navigateTo(context, const CartScreen());
                        },
                        child: Container(
                          width: double.infinity,
                          height: 45,
                          decoration: BoxDecoration(
                            color: Colors.black38,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: const [
                                Icon(Icons.shopping_cart),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Cart',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Spacer(),
                                Icon(Icons.arrow_forward_ios),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      InkWell(
                        onTap: () {
                          ShopCubit.get(context).changeBottom(2);
                        },
                        child: Container(
                          width: double.infinity,
                          height: 45,
                          decoration: BoxDecoration(
                            color: Colors.black38,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: const [
                                Icon(IconBroken.Heart),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Favorites',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Spacer(),
                                Icon(Icons.arrow_forward_ios),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 100,),
                      Align(
                        alignment: AlignmentDirectional.bottomCenter,
                        child:InkWell(
                          onTap: () {
                            signOut(context);
                          },
                          child: Container(
                            width: double.infinity,
                            height: 45,
                            decoration: BoxDecoration(
                              color: Colors.black38,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: const [
                                  Icon(IconBroken.Logout),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'LOGOUT',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(Icons.arrow_forward_ios),
                                ],
                              ),
                            ),
                          ),
                        ),

                      ),

                    ],
                  ),
                ),
              );
            },
            fallbackBuilder: (BuildContext context) => const Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}

