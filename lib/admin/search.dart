import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/admin/updatePost.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

import 'cubit/cubit.dart';
import 'cubit/state.dart';

class SearchAdminScreen extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return BlocConsumer<AdminCubit, AdminState>(
            builder: (context, state) {
              var cubit = AdminCubit.get(context);
              return Scaffold(
                appBar: AppBar(),
                body: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      defaultFormField(
                          textEditingController: searchController,
                          type: TextInputType.text,
                          validate: (value) {
                            if (value != null) {}
                            return 'اكتب اسم';
                          },
                          label: 'اكتب اسم الناشر',
                          prefix: IconBroken.Send,
                          suffix: Icons.send,
                          fSuffix: () {
                            if (searchController.text != "") {
                              cubit.searchPost(searchController.text);
                              searchController.text = '';
                            }
                            return 'أكتب اسم';
                          },
                          onSubmitted: (value) {
                            cubit.searchPost(searchController.text);
                            searchController.text = '';
                          }),
                      SizedBox(
                        height: 15.0,
                      ),
                      (cubit.postsSearch.length > 0)
                          ? ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => buildPostItem(
                                  context, cubit.posts[index], index),
                              itemCount: cubit.posts.length,
                              separatorBuilder:
                                  (BuildContext context, int index) => SizedBox(
                                height: 10.0,
                              ),
                            )
                          : Center(
                              child: load(),
                            ),
                    ],
                  ),
                ),
              );
            },
            listener: (context, state) {});
      },
    );
  }

  Widget buildPostItem(context, PostsModel postModel, index) => Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5.0,
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(
                      "${postModel.image}",
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
                            "${postModel.name}",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              height: 1.4,
                            ),
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
                      Text(
                        "${postModel.dateTime.toString()}",
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              height: 1.4,
                            ),
                      ),
                    ],
                  )),
                  SizedBox(
                    width: 15.0,
                  ),
                  IconButton(
                      onPressed: () {
                        showMyDialog(context, postModel);
                      },
                      icon: Icon(
                        Icons.delete,
                        size: 16.0,
                      )),
                  IconButton(
                      onPressed: () {
                        navigateTo(context, UpdatePostScreen(model: postModel,));
                      },
                      icon: Icon(
                        Icons.edit,
                        size: 16.0,
                      )),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Divider(),
              ),
              if (postModel.text != null && postModel.text != '')
                Text(
                  "${postModel.text}",
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontFamily: 'Jannah',
                      ),
                ),
              if (postModel.postImage != '' && postModel.postImage != null)
                Padding(
                  padding: const EdgeInsetsDirectional.only(top: 15.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      image: DecorationImage(
                        image: NetworkImage("${postModel.postImage}"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            children: [
                              Icon(
                                IconBroken.Heart,
                                color: Colors.red,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                "${postModel.likes ?? 0}",
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                IconBroken.Chat,
                                color: Colors.amber,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                "${postModel.comments} تعليق",
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

}


