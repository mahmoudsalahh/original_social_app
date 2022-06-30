import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'state.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());
  static SocialCubit  get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  void changeIndex (index){
    currentIndex = index;
    emit(SocialChangeItemState());
  }
  List <String> titles = [
    'Feeds',
    'Users',
    'Notifications',
    'Settings'
  ];
  List <BottomNavigationBarItem> items = [
  BottomNavigationBarItem(
      icon: Icon(Icons.menu),
    label: 'Feeds'

      ),
    BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'Users'


    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.notifications_active_outlined),
        label: 'Notification'


    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: 'Settings'


    ),
  ];
}

