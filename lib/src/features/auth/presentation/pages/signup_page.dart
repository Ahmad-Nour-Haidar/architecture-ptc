import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/helper/sizer_media_query.dart';
import '../../../../../core/utils/assets_manager.dart';
import '../../../../../core/utils/color_manager.dart';
import '../../../../../core/utils/style_manager.dart';
import '../../../../../core/utils/validator_manager.dart';
import '../../../../../core/utils/values_manager.dart';
import '../../../../../core/widgets/textfield_app.dart';
import '../../../../../core/widgets/textfield_with_label.dart';
import '../../../core/presentation/cubits/user_cubit/user_cubit.dart';
class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final firstNameController = TextEditingController();

  final lastNameController = TextEditingController();

  final emailController = TextEditingController();

  final imageController = TextEditingController();


  final birthdateController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmController = TextEditingController();

  final aboutMeController = TextEditingController();




  DateTime firstDate = DateTime(1940);

  DateTime lastDate = DateTime.now();

  XFile? _imagePick;

  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  Future<void> _pickerFromGallery(
      BuildContext context, Function setState) async {
    final imageGallery = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (imageGallery != null) {
      setState(() {
        _imagePick = XFile(imageGallery.path);
        Navigator.pop(context);
      });
      log(imageGallery.path);
    }
  }

  Future<void> _pickerFromCamera(
      BuildContext context, Function setState) async {
    final imageCamera = await _picker.pickImage(
      source: ImageSource.camera,
    );
    if (imageCamera != null) {
      setState(() {
        _imagePick = XFile(imageCamera.path);
      });
      Navigator.pop(context);
      log(imageCamera.path);
    }
  }

  void _deletePicker(BuildContext context, Function setState) {
    setState(() {
      _imagePick = null;
    });
    Navigator.pop(context);
  }




  register() async {

    await context.read<UserCubit>().register(context,
        email: emailController.value.text,
        password: passwordController.value.text,
        firstName: firstNameController.value.text,
        lastName: lastNameController.value.text,
        image: _imagePick?.path??'',
      );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SafeArea(
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
                  const Text(
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
                  const Text(
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
                  StatefulBuilder(builder: (context, setStatePicker) {
                    return Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.hardEdge,
                      children: [
                        AnimatedContainer(
                          clipBehavior: Clip.hardEdge,
                          duration: const Duration(milliseconds: 300),
                          width: getWidth(context) * 0.3,
                          height: getWidth(context) * 0.3,
                          decoration: BoxDecoration(
                              color: ColorManager.primary,
                              shape: BoxShape.circle,
                              border: _imagePick != null
                                  ? Border.all(
                                      color: ColorManager.secondary,
                                      width: AppSize.s4)
                                  : null),
                          child: _imagePick == null
                              ? Icon(
                                  Icons.person,
                                  size: getWidth(context) * 0.2,
                                )
                              : ClipOval(
                                  child: Image.file(
                                    File(_imagePick!.path),
                                    width: getWidth(context) * 0.3,
                                    height: getWidth(context) * 0.3,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        Positioned(
                          right: getWidth(context) / 3.25,
                          bottom: 0,
                          child: IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(AppSize.s24))),
                                builder: (_) => Padding(
                                  padding:
                                      const EdgeInsets.only(top: AppPadding.p12),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 76,
                                        height: 5,
                                        decoration: BoxDecoration(
                                            color: ColorManager.primary,
                                            borderRadius:
                                                BorderRadius.circular(100.0)),
                                      ),
                                      const SizedBox(
                                        height: AppSize.s10,
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.width /
                                                2.5,
                                        child: Column(
                                          children: [
                                            _buildImagePicker(
                                                title: 'Pick From Gallery',
                                                icon: Icons.image,
                                                onTap: () => _pickerFromGallery(
                                                    context, setStatePicker)),

                                            ///
                                            divider(
                                              indent:
                                                  getWidth(context) / AppSize.s6,
                                            ),
                                            _buildImagePicker(
                                                title: 'Pick From Camera',
                                                icon: Icons.camera_alt,
                                                onTap: () => _pickerFromCamera(
                                                    context, setStatePicker)),

                                            ///
                                            divider(
                                              indent:
                                                  getWidth(context) / AppSize.s6,
                                            ),
                                            _buildImagePicker(
                                                title: 'Delete Photo',
                                                icon: Icons.delete,
                                                onTap: () => _deletePicker(
                                                    context, setStatePicker)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            icon: CircleAvatar(
                              backgroundColor: ColorManager.white,
                              child: Icon(
                                Icons.add_a_photo,
                                size: getWidth(context) * 0.05,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                  const SizedBox(
                    height: AppSize.s20,
                  ),

                  ///fName
                  TextFieldWithLabel(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppPadding.p12),
                    label: 'First Name',
                    child: TextFiledApp(
                      validator: (value)=>ValidatorManager().validateName(value!),
                      controller: firstNameController,
                      hintText: 'Enter Your First name',
                    ),
                  ),
                  const SizedBox(
                    height: AppSize.s20,
                  ),

                  ///lName
                  TextFieldWithLabel(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppPadding.p12),
                    label: 'Last Name',
                    child: TextFiledApp(
                      validator: (value)=>ValidatorManager().validateName(value!),
                      controller: lastNameController,
                      hintText: 'Enter Your Last name',
                    ),
                  ),
                  const SizedBox(
                    height: AppSize.s20,
                  ),

                  ///Email
                  TextFieldWithLabel(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppPadding.p12),
                    label: 'Email',
                    child: TextFiledApp(
                      validator: (value)=>ValidatorManager().validateEmail(value!),
                      controller: emailController,
                      hintText: 'Enter Your Email',
                    ),
                  ),
                  const SizedBox(
                    height: AppSize.s20,
                  ),


                  ///Password
                  TextFieldWithLabel(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppPadding.p12),
                    label: 'Password',
                    child: TextFiledApp(
                      validator: (value)=>ValidatorManager().validatePassword(value!),
                      controller: passwordController,
                      obscureText: true,
                      suffixIcon: true,
                      hintText: 'Enter Your Password',
                    ),
                  ),
                  const SizedBox(
                    height: AppSize.s20,
                  ),

                  ///Confirm Password
                  TextFieldWithLabel(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppPadding.p12),
                    label: 'Confirm Password',
                    child: TextFiledApp(
                      validator: (value)=>ValidatorManager().validateConfirmPassword(value!,passwordController.text),
                      controller: confirmController,
                      obscureText: true,
                      suffixIcon: true,
                      hintText: 'Confirm Password',
                    ),
                  ),
                  const SizedBox(
                    height: AppSize.s20,
                  ),


                  ///aboutMe
                  TextFieldWithLabel(
                    padding:
                    const EdgeInsets.symmetric(horizontal: AppPadding.p12),
                    label: 'About me',
                    child: TextFiledApp(
                      validator: (value)=>ValidatorManager().validateName(value!),
                      maxLine: 5,
                      controller: aboutMeController,
                      hintText: 'Enter Your about me',
                    ),
                  ),
                  const SizedBox(
                    height: AppSize.s20,
                  ),

                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppPadding.p12),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.primary,
                          minimumSize: const Size(double.infinity, AppSize.s50)),
                      onPressed: () {
                        if(_formKey.currentState!.validate()){
                          register();

                        }
                      },
                      child: const Text('Sign up'),
                    ),
                  ),
                  const SizedBox(
                    height: AppSize.s20,
                  ),
                ],
              ),
            ),
          ),
        ),

    );
  }

  Widget _buildImagePicker(
      {required String title,
      required IconData icon,
      required void Function()? onTap}) {
    return Expanded(
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon),
        title: Text(title),
        dense: true,
        splashColor: ColorManager.secondary,
        style: ListTileStyle.list,
      ),
    );
  }
}
