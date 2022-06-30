import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:original_social_app/moduls/home_screen/home_screen.dart';
import 'package:original_social_app/moduls/login/login_cubit/cubit.dart';
import 'package:original_social_app/moduls/login/login_cubit/states.dart';
import 'package:original_social_app/moduls/register/register_screen.dart';
import 'package:original_social_app/shared/shared.component/component.dart';

class LoginScreen extends StatefulWidget {
  //const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  bool obsecure = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, SocialLoginStates>(
        listener: (context, state) {
          if (state is SocialLoginErrorState) {

              showToast(
                  text: state.error,
                  state: ToastState.ERROR);

        }else{
            navigateAndRemoveUntil(context, HomeScreen());
          }
          },
        builder: (context, state) => Scaffold(

            body: Center(
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'LOGIN',
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Text(
                            'Login Now to communicate with your friends ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.grey),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          defaulttextformfeild(

                              controller: emailController,
                              label: 'Email',
                              validate: (value) {
                                if (value.isEmpty) {
                                  return 'Email is Wrong';
                                }
                                return null;
                              },
                              prefix: Icons.email_outlined),
                          SizedBox(
                            height: 20.0,
                          ),
                          defaulttextformfeild(
                            onSubmit: (value){
                              if (formKey.currentState!.validate()) {
                                LoginCubit.get(context).loginUser(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            controller: passwordController,
                            label: 'Password',
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'Password is Too Short';
                              }
                              return null;
                            },
                            obsecureText: obsecure,
                            suffixPressed: () {
                              setState(() {
                                obsecure = !obsecure;
                              });
                            },
                            prefix: Icons.lock,
                            suffix: obsecure
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          ConditionalBuilder(
                            condition:state is! SocialLoginLoudingState ,
                            builder: (context) => defaultButton(
                                onpressed: () {
                                  //token = LoginCubit.get(context).loginModel!.data!.token!;
                                  if (formKey.currentState!.validate()) {

                                    LoginCubit.get(context).loginUser(
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }
                                },
                                text: 'LOGIN'),
                            fallback: (context) =>
                                Center(child: CircularProgressIndicator()),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don/t have an Accont ? ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              defaultTextButton(
                                  text: 'REGISTER',
                                  onpressed: () {
                                    navigateTo(context, RegisterScreen());
                                  })
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
