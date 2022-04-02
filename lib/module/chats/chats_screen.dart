import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/module/chats/chat_details_screen.dart';
import 'package:social_app/shared/components/components.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (c, s) {},
      builder: (c, s) {
        var cubit = SocialCubit.get(context);
        return (cubit.users != null)
            ? ListView.separated(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) =>
                    buildChatUserItem(context, cubit.users[index]),
                itemCount: cubit.users.length,
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(),
              )
            : load();
      },
    );
  }

  Widget buildChatUserItem(context, UserModel model) => InkWell(
    onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (c)=> ChatDetailsScreen(model)));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
            children: [
              CircleAvatar(
                radius: 30.0,
                backgroundImage: NetworkImage(
                  "${model.image}",
                ),
              ),
              SizedBox(
                width: 15.0,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "${model.name}",
                        style: Theme.of(context).textTheme.caption,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Icon(
                        Icons.check_circle,
                        color: Colors.blue,
                        size: 16.0,
                      ),
                    ],
                  ),
                ],
              )),
            ],
          ),
    ),
  );
}
