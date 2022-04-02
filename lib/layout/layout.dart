import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/module/new_post/new_post_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/cubit/cubit.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class SocialLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
            actions: [
              IconButton(onPressed: (){}, icon: Icon(IconBroken.Notification)),
              IconButton(onPressed: (){}, icon: Icon(IconBroken.Search)),
            ],
            leading: IconButton(onPressed: (){
              AppCubit.get(context).changeAppMode();
            }, icon: Icon(Icons.brightness_4_outlined)),
          ),
          body: cubit.userModel != null
              ? cubit.screens[cubit.currentIndex]
              : load(),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeBottomNav(index);
            }, items: [
            BottomNavigationBarItem(icon: Icon(IconBroken.Home), label: 'آخر الأخبار'),
            BottomNavigationBarItem(icon: Icon(IconBroken.Chat), label: 'الدردشة'),
            BottomNavigationBarItem(icon: Icon(IconBroken.Upload), label: 'انشر خبر'),
            BottomNavigationBarItem(icon: Icon(IconBroken.User), label: 'صحفيين'),
            BottomNavigationBarItem(icon: Icon(IconBroken.Setting), label: 'إعدادات'),
          ],
          ),
        );
      },
      listener: (context, state) {
        if(state is SocialNewPostState){
          Navigator.push(context, MaterialPageRoute(builder: (context) => NewPostScreen()));
        }
      },
    );
  }
}
/*
* if (!FirebaseAuth.instance.currentUser!.emailVerified)
                      Container(
                        color: Colors.amber.withOpacity(.6),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            children: [
                              Icon(Icons.info_outline),
                              SizedBox(
                                width: 15.0,
                              ),
                              Expanded(child: Text("تأكيد الإيميل")),
                              SizedBox(
                                width: 15.0,
                              ),
                              TextButton(
                                onPressed: () {
                                  FirebaseAuth.instance.currentUser!
                                      .sendEmailVerification()
                                      .then((value){
                                        showToast(message: 'تفقد الإيميل', states: ToastStates.SUCCESS);
                                  })
                                      .catchError((error){
                                    showToast(message: 'خطأ', states: ToastStates.ERROR);
                                  });
                                },
                                child: Text(
                                  "إرسال",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),*/