import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:original_social_app/moduls/home_screen/home_screen.dart';
import 'package:original_social_app/moduls/register/register_cubit/cubit.dart';
import 'package:original_social_app/moduls/register/register_cubit/states.dart';
import 'package:original_social_app/shared/shared.component/component.dart';


class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  bool obsecure = true;


  @override
  Widget build(BuildContext context) {
    return
      BlocProvider(
        create: (BuildContext context)=>RegisterCubit(),
         child: BlocConsumer<RegisterCubit, SocialRegisterStates>(
        listener: (context , state){
          // if (state is SocialRegisterSucceesState) {
          //   if (state.loginModel!.status) {
          //     CacheHelper.saveData(key: 'token', value: state.loginModel!.data!.token).then((value) {
          //       navigateTo(context, HomeScreen());
          //     });
          //   } else {
          //     showToast(
          //         text: state.loginModel!.message!,
          //         state: ToastState.ERROR);
          //   }
          // }
        },
    builder: (context , state)=>
      Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Container(
              height: 600,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100.0),topRight:Radius.circular(100.0) ),
                //borderRadius: BorderRadius.only(topRight: Radius.circular(40.0)),
                image:DecorationImage(image:AssetImage('assets/hh.jpg'),fit:BoxFit.cover ),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0, bottom: 30.0),
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80.0),topRight:Radius.circular(80.0) ),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,

                      height: 450,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'REGISTER',
                                style: Theme.of(context).textTheme.headline5!.copyWith(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10.0,),
                              Text(
                                'Register Now to communicate with your friends',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: Colors.grey),
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              defaulttextformfeild(
                                  controller: nameController,
                                  label: 'Name',
                                  validate: (value) {
                                    if (value.isEmpty) {
                                      return 'Enter Your Name';
                                    }
                                    return null;
                                  },
                                  prefix: Icons.person),
                              SizedBox(
                                height: 10.0,
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
                              SizedBox(height: 10.0,),
                              defaulttextformfeild(
                                controller: passwordController,
                                label: 'Password',
                                validate: (value) {
                                  if(value.isEmpty){
                                    return 'Password is Too Short';
                                  }
                                  return null ;
                                },
                                obsecureText: obsecure,
                                suffixPressed: (){
                                  setState(() {
                                    obsecure = !obsecure;
                                  });
                                },
                                prefix: Icons.lock,
                                suffix: obsecure? Icons.visibility_outlined : Icons.visibility_off_outlined,
                              ),
                              SizedBox(height: 10.0,),
                              defaulttextformfeild(
                                controller: phoneController,
                                label: 'Phone',
                                validate: (value) {
                                  if(value.isEmpty){
                                    return 'Phone is not correct';
                                  }
                                  return null ;
                                },
                                prefix: Icons.phone,
                              ),
                              SizedBox(height: 15.0,),
                              ConditionalBuilder(
                                condition: state is! SocialRegisterLoudingState,
                                builder:(context) =>  Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(80.0),
                                        topRight:Radius.circular(80.0),
                                      topLeft: Radius.circular(10.0),
                                      bottomRight: Radius.circular(10.0)
                                    ),
                                  ),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: defaultButton(
                                    onpressed: (){
                                      if(formKey.currentState!.validate()){
                                        RegisterCubit.get(context).registerUser(
                                            email: emailController.text,
                                            password: passwordController.text,
                                          name: nameController.text,
                                          phone: phoneController.text,
                                        );
                                        navigateAndRemoveUntil(context, HomeScreen());


                                      } },
                                    text: 'REGISTER' ),),
                                fallback: (context)=>Center(child: CircularProgressIndicator()),
                              ),


                            ],

                    ),
                      )

              ),
                  ),

            ]),
            ),
          ),
      ),
    ))));
  }
}
