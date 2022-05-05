import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:shop_app/shared/styles/icon_broken.dart';
import '../../shared/components/components.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

class EditScreen extends StatelessWidget {
  const EditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var emailController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => ShopCubit()..getUserData(),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var model = ShopCubit.get(context).userDataModel;
          return Conditional.single(
            context: context,
            conditionBuilder: (BuildContext context) =>
            ShopCubit.get(context).userDataModel != null,
            widgetBuilder: (BuildContext context) {
              emailController.text = model!.data!.email!;
              nameController.text = model.data!.name!;
              phoneController.text = model.data!.phone!;
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Edit'),
                  actions: const [
                    Icon(IconBroken.Edit_Square),
                  ],
                ),
                body: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            if (state is ShopLoadingUpdateUserState)
                              const LinearProgressIndicator(),
                            const SizedBox(
                              height: 25,
                            ),
                            defaultFormField(
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              label: 'Email',
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Email must not be empty';
                                }
                                return null;
                              },
                              prefixIcon: IconBroken.Message,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            defaultFormField(
                              controller: nameController,
                              type: TextInputType.name,
                              label: 'Name',
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Name must not be empty';
                                }
                                return null;
                              },
                              prefixIcon: IconBroken.User,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            defaultFormField(
                              controller: phoneController,
                              type: TextInputType.phone,
                              label: 'Phone',
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Phone must not be empty';
                                }
                                return null;
                              },
                              prefixIcon: IconBroken.Call,
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            defaultButton(
                                background: Colors.black38,
                                radius: 25,
                                text: 'Update',
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    ShopCubit.get(context).updateUserData(
                                      name: nameController.text,
                                      email: emailController.text,
                                      phone: phoneController.text,
                                    );
                                  }
                                }),
                            const SizedBox(
                              height: 35,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
            fallbackBuilder: (BuildContext context) =>
            const Center(child: CircularProgressIndicator()),
          );
        },
      ),
    )
    ;
  }
}
