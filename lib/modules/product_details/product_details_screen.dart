import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/shop_app/home_model.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';
class ProductDetailsScreen extends StatelessWidget {
  int index;
  ProductsModel model;
   ProductDetailsScreen({
    Key? key,
    required this.index,
    required this.model,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit=ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              SingleChildScrollView(child:
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:  [
                  Container(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.bottomStart,
                          children: [
                            Image(
                              image: NetworkImage(model.image),
                              width: double.infinity,
                              height: 350,
                            ),
                            if (model.discount != 0)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                color: Colors.red,
                                child: const Text(
                                  'DISCOUNT',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                model.name,
                                style: const TextStyle(
                                  height: 1.3,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Text(
                                    '${model.price.round()} LE',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: defaultColor,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  if (model.discount != 0)
                                    Text(
                                      '${model.oldPrice.round()} LE',
                                      style: const TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],

              )
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: defaultButton(
                  text: "Add To Cart",
                  function: (){
                    cubit.addToCart(model);
                    showToast(text: "Item added to the cart", state: ToastStates.SUCCESS);
                    Navigator.pop(context);
                  },
                  background: Colors.deepOrange,
                  radius: 15,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
