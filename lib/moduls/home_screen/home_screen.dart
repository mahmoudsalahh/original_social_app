
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:original_social_app/shared/social_cubit/cubit.dart';

import '../../shared/social_cubit/state.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialCubit(),
      child: BlocConsumer<SocialCubit ,SocialStates>(
        listener: (BuildContext context, Object? state) {  },
        builder: (BuildContext context, state)=>
            Scaffold(
              appBar: AppBar(
                title: Text(SocialCubit.get(context).titles[SocialCubit.get(context).currentIndex]),
              ),

              bottomNavigationBar: BottomNavigationBar(
                currentIndex: SocialCubit.get(context).currentIndex,
                items: SocialCubit.get(context).items,
              ),
            ) ,


      ),

    );
  }
}
