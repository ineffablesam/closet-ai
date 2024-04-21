import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../main.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _setupAuthListener();
  }

  void _setupAuthListener() {
    supabase.auth.onAuthStateChange.listen((data) {
      final event = data.event;
      if (event == AuthChangeEvent.signedIn) {
        print('User signed in: ${data.session?.user?.email}');
      } else if (event == AuthChangeEvent.signedOut) {
        print('User signed out');
      }
    });
  }

  // function to signout
  // Future<void> signOut() async {
  //   await supabase.auth.signOut();
  // }
  Future<AuthResponse> googleSignIn() async {
    isLoading.value = true;
    const webClientId =
        '109985204482-1rhf4gsh96b1s8hjvmumuttrdts897rq.apps.googleusercontent.com';

    /// TODO: update the iOS client ID with your own.
    ///
    /// iOS Client ID that you registered with Google Cloud.
    const iosClientId =
        '109985204482-bvhkjmrjkgf9tobib5k9cfuonuq9jlhj.apps.googleusercontent.com';
    // wait for 2 seconds
    await Future.delayed(const Duration(seconds: 2));
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        clientId: iosClientId,
        serverClientId: webClientId,
      );
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        throw 'Google sign in aborted by user.';
      }

      final googleAuth = await googleUser.authentication;
      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;

      if (accessToken == null) {
        throw 'No Access Token found.';
      }
      if (idToken == null) {
        throw 'No ID Token found.';
      }

      saveUserToken(idToken);

      return supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );
    } catch (error) {
      // Handle the error here
      print('Google Sign-In Error: $error');
      throw error;
    } finally {
      isLoading.value = false;
    }
  }

  // function to saved the user data using shared preferences and push to /home
  void saveUserToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    debugPrint('Token saved: $token');
    Get.offNamed('/home');
  }
}
