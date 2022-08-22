import 'dart:developer';

import 'package:app/src/data/model/account.dart' as local;
import 'package:app/src/data/network/app_client.dart';
import 'package:app/src/data/network/request/login_email_param.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRepository {
  static Future<local.Account> loginWithEmail(String email, String password) {
    return appApi.loginWithEmailAndPassword(
        LoginEmailParam(email: email, password: password));
  }

  static Future<local.User> getMyProfile() {
    return appApi.getMyProfile();
  }

  static Future<UserCredential?> signInByGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<UserCredential?> signInByFacebook() async {
    try {
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken?.token ?? '');

      // Once signed in, return the UserCredential
      return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
