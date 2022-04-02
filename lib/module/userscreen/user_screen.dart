import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/module/UserProfileScreen/user_profile_screen.dart';
import 'package:social_app/shared/components/components.dart';

class UsersScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Conditional.single(
            context: context,
            conditionBuilder: (context) => true,
            widgetBuilder: (context) => Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => buildUsersListItem(
                      context,
                      SocialCubit.get(context).users[index],
                      ProfileScreen(
                          user: SocialCubit.get(context).users[index])),
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: SocialCubit.get(context).users.length),
            ),
            fallbackBuilder: (context) =>
                Center(child: CircularProgressIndicator()));
      },
    );
  }
}
