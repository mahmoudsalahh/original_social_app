import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:original_social_app/moduls/register/register_cubit/states.dart';

class RegisterCubit extends Cubit<SocialRegisterStates>{

  RegisterCubit() : super(SocialRegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void registerUser({
    required String email ,
    required String password,
    required String name,
    required String phone,
  }){
    emit(SocialRegisterLoudingState());
    // DioHelper.postData(
    //     url: REGISTER,
    //     data: {
    //       'name' : name,
    //       'email':email,
    //       'password':password,
    //       'phone':phone,
    //     }).then((value){
    //   // print(value.data);
    //   loginModel = ShopLoginModel.fromJson(value.data);
    //   //print(loginModel!.message);
    //   emit(ShopRegisterSucceesState(loginModel!));
    // }).catchError((error){
    //   emit(ShopRegisterErrorState(error.toString()));
    // });
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
    ).then((value) {
      print(value.user!.email);
      print(value.user!.uid);

      emit(SocialRegisterSuccessState());
    }
    ).catchError(
            (error){
              emit(SocialRegisterErrorState(error));
              print(error.toString());
            });

  }

  void CreateUser({
    required String email ,
    required String name,
    required String phone,
    required String uId,

  })
  {
    FirebaseFirestore.instance.
    collection('users').
    doc(uId).
    set({

});
  }

  ImagePicker imagepicker = ImagePicker();
  XFile? userImage;
  Image(String Camera) async{
    if (Camera == "cam"){
      userImage = await imagepicker.pickImage(source: ImageSource.camera);
      return userImage?.readAsBytes();
    }

}
}