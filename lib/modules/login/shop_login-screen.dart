import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

import '../../layout/shop_layout/shop_layout_screen.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/networks/local/cache_helper.dart';
import '../../shared/styles/icon_broken.dart';
import '../register/shop_register_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ShopLoginScreen extends StatelessWidget {
  const ShopLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, states) {
          if (states is ShopLoginSuccessState) {
            if (states.loginModel.status!) {
              if (kDebugMode) {
                print(states.loginModel.message);
              }
              showToast(
                  text: states.loginModel.message.toString(),
                  state: ToastStates.SUCCESS);
              if (kDebugMode) {
                print(states.loginModel.data!.token);
              }
              CacheHelper.saveData(
                      key: 'token', value: states.loginModel.data!.token)
                  .then((value) {
                token = states.loginModel.data!.token!;
                navigateAndFinish(context, const ShopLayoutScreen());
              });
            } else {
              if (kDebugMode) {
                print(states.loginModel.message);
              }
              showToast(
                text: states.loginModel.message,
                state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (context, states) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Image(
                            image: AssetImage('assets/images/login4.png'),
                            height: 200,
                            width: 200,
                          ),
                        ),
                        const Center(
                          child: Text(
                            'LOGIN',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const Center(
                          child: Text(
                            'login now to browse our hot offers',
                            style: TextStyle(
                              //fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          label: 'Email Address',
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'email must be not empty';
                            }
                          },
                          prefixIcon: IconBroken.Message,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          function: () {
                            ShopLoginCubit.get(context)
                                .changePasswordVisibility();
                          },
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          label: 'Password',
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'password must be not empty';
                            }
                          },
                          prefixIcon: IconBroken.Unlock,
                          suffixIcon: ShopLoginCubit.get(context).suffix,
                          isPassword: ShopLoginCubit.get(context).isPassword,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Conditional.single(
                          context: context,
                          conditionBuilder: (BuildContext context) =>
                              states is! ShopLoginLoadingState,
                          widgetBuilder: (BuildContext context) =>
                              defaultButton(
                            radius: 25,
                            text: 'Login',
                            background: Colors.black38,
                            function: () {
                              if (formKey.currentState!.validate()) {
                                ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                          ),
                          fallbackBuilder: (BuildContext context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don\'t have an account?'),
                            TextButton(onPressed: () {
                              navigateTo(
                                  context, const ShopRegisterScreen());
                            }, child: const Text('REGISTER',
                              style: TextStyle(
                                color: Colors.black38
                              ),

                            )),

                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
