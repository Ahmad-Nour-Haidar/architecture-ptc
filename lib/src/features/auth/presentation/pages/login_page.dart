import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/helper/sizer_media_query.dart';
import '../../../../../core/utils/color_manager.dart';
import '../../../../../core/utils/validator_manager.dart';
import '../../../../../core/utils/values_manager.dart';
import '../../../../../core/utils/assets_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/widgets/container_with_image.dart';
import '../../../../../core/widgets/textfield_app.dart';
import '../../../../../core/widgets/textfield_with_label.dart';
import '../../../core/presentation/cubits/user_cubit/user_cubit.dart';
import 'signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool rememberMe = false;
  final _formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  login() async {
    await context.read<UserCubit>().login(
          context,
          email: emailController.value.text,
          password: passwordController.value.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AssetsManager.logoIMG,
                    width: getWidth(context) / 3,
                    height: getWidth(context) / 3,
                  ),
                  const SizedBox(
                    height: AppSize.s20,
                  ),
                  Text(
                    'welcome to',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: ColorManager.white),
                  ),
                  const SizedBox(
                    height: AppSize.s10,
                  ),
                  Text(
                    'PTC',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                        color: ColorManager.white),
                  ),
                  const SizedBox(
                    height: AppSize.s20,
                  ),
                  TextFieldWithLabel(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppPadding.p12),
                    label: 'Welcome Back!',
                    child: TextFiledApp(
                      validator: (value) =>
                          ValidatorManager().validateEmail(value!),
                      controller: emailController,
                      hintText: 'Enter Your Email',
                    ),
                  ),
                  const SizedBox(
                    height: AppSize.s20,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppPadding.p12),
                    child: TextFiledApp(
                      validator: (value) =>
                          ValidatorManager.instance.validatePassword(value!),
                      controller: passwordController,
                      obscureText: true,
                      suffixIcon: true,
                      hintText: 'Enter Your Password',
                    ),
                  ),
                  const SizedBox(
                    height: AppSize.s10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: StatefulBuilder(
                            builder: (context, setStateCheckBox) {
                          return InkWell(
                            onTap: () {
                              setStateCheckBox(() {
                                rememberMe = !rememberMe;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: AppPadding.p12),
                              child: Row(
                                children: [
                                  Icon(
                                    rememberMe
                                        ? Icons.check_box
                                        : Icons.check_box_outline_blank,
                                    color: ColorManager.primary,
                                  ),
                                  Text(
                                    'Remember me',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: ColorManager.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            ///Code here
                          },
                          child: Text(
                            'Forgot Your Password ? ',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: ColorManager.secondary,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: AppSize.s10,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppPadding.p12),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.primary,
                          minimumSize:
                              const Size(double.infinity, AppSize.s50)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          login();
                        }
                      },
                      child: Text('Login'),
                    ),
                  ),
                  const SizedBox(
                    height: AppSize.s20,
                  ),
                  Text(
                    'Not a Member ? ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: ColorManager.white,
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => SignupPage()));
                      },
                      child: Text(
                        'Signup',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w500,
                          color: ColorManager.secondary,
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
