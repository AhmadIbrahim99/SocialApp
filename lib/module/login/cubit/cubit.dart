
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/module/login/cubit/state.dart';
import 'package:social_app/shared/components/constants.dart';

class SocialLoginCubit extends Cubit<SocialLogInState> {
  SocialLoginCubit() : super(SocialLogInInitialState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);

  void userSignIn({
    required String email,
    required String password,
  }) {
    emit(SocialLogInLoadState());

    if(email =="hemanews@hemanews.org" && password =="hema123"){
      emit(SocialLogInAdminSuccessState());
    }else{
      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        uId = value.user!.uid;
        emit(SocialLogInSuccessState('${value.user!.uid}'));
      })
          .catchError((error) {
        emit(SocialLogInErrorState('${error.toString()}'));
      });
    }

    emit(SocialLogInAdminErrorState());

  }


}
