/*
import 'dart:convert';
import 'dart:io';

//import 'package:fb_auth_login/fb_auth_login.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//import 'package:flutter_login_facebook/flutter_login_facebook.dart';
//import 'package:flutter_login_facebook/flutter_login_facebook.dart';
//import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import 'basket_ball/domain/entities/user_data_info.dart';




*/
/*
 dont forget firebase_auth: any
             google_sign_in: any

  and you should  enable google People api //////
  fire base  authenticate google ///
  put email
 *//*



final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

Future<dynamic> signInWithGoogle() async {
  print("this is google");
  try{final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
  await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final AuthResult authResult = await _auth.signInWithCredential(credential);
  final FirebaseUser user = authResult.user;

  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);
  print(user.toString());
  print(user.email);
  print(user.displayName);
  print(user.phoneNumber);
  print(user.photoUrl);
  return UserInfoEntities(firstName: user.displayName.split(' ').first,lastName: user.displayName.split(' ').last,email: user.email);
  }catch(e){
    print(e);
    return 'canceled';
  }

}

void signOutGoogle() async {
  await googleSignIn.signOut();

  print("User Sign Out");
}

//sign in with facebook
String token;
printCredentials(LoginResult result) {
  token = result.accessToken.token;
  print("userId: ${result.accessToken.userId}");
  print("token: $token");
  print("expires: ${result.accessToken.expires}");
  print("grantedPermission: ${result.grantedPermissions}");
  print("declinedPermissions: ${result.declinedPermissions}");
}

Future<UserInfoEntities>_checkIfIsLogged() async {
  final AccessToken accessToken = await FacebookAuth.instance.isLogged;
  if (accessToken != null) {
    print("is Logged");
    // now you can call to  FacebookAuth.instance.getUserData();
    final userData = await FacebookAuth.instance.getUserData();
    // final userData = await FacebookAuth.instance.getUserData(fields:"email,birthday");
    token = accessToken.token;
    Map user = userData;
    return UserInfoEntities(firstName: user['name'].toString().split(" ").first,lastName:  user['name'].toString().split(" ").last,email: user['email']);
  }

}

Future<dynamic> loginFacebook() async {
  final result = await FacebookAuth.instance.login();
  // final result = await FacebookAuth.instance.login(permissions:['email','user_birthday']);

  switch (result.status) {
    case FacebookAuthLoginResponse.ok:
      printCredentials(result);
      // get the user data
      final userData = await FacebookAuth.instance.getUserData();
      // final userData = await _fb.getUserData(fields:"email,birthday");
      Map user = userData;
      return UserInfoEntities(firstName: user['name'].toString().split(" ").first,lastName:  user['name'].toString().split(" ").last,email: user['email']);
      break;
    case FacebookAuthLoginResponse.cancelled:
      print("login cancelled");
      return "cancel";
      break;
    default:
      print("login failed");
      return 'failed';
  }
}

logOut() async {
  await FacebookAuth.instance.logOut();
}

checkPermissions() async {
  final FacebookAuthPermissions response =
  await FacebookAuth.instance.permissions(token);
  print("permissions granted: ${response.granted}");
  print("permissions declined: ${response.declined}");
}


// apple example


Future<dynamic> signWithApple()async{
  try{
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      webAuthenticationOptions: WebAuthenticationOptions(
        // TODO: Set the `clientId` and `redirectUri` arguments to the values you entered in the Apple Developer portal during the setup
        clientId:
        'com.aboutyou.dart_packages.sign_in_with_apple.example',
        redirectUri: Uri.parse(
          'https://flutter-sign-in-with-apple-example.glitch.me/callbacks/sign_in_with_apple',
        ),
      ),
      // TODO: Remove these if you have no need for them
      nonce: 'example-nonce',
      state: 'example-state',
    );

    print(credential);

    // This is the endpoint that will convert an authorization code obtained
    // via Sign in with Apple into a session in your system
    final signInWithAppleEndpoint = Uri(
      scheme: 'https',
      host: 'flutter-sign-in-with-apple-example.glitch.me',
      path: '/sign_in_with_apple',
      queryParameters: <String, String>{
        'code': credential.authorizationCode,
        'firstName': credential.givenName,
        'lastName': credential.familyName,
        'useBundleId':
        Platform.isIOS || Platform.isMacOS ? 'true' : 'false',
        if (credential.state != null) 'state': credential.state,
      },
    );

    final session = await http.Client().post(
      signInWithAppleEndpoint,
    );

    // If we got this far, a session based on the Apple ID credential has been created in your system,
    // and you can now set this as the app's session
    print(session);
    return UserInfoEntities(firstName: credential.givenName,lastName: credential.familyName,email: credential.email);
  }catch(e){
    print("cancel : $e");
  }
}

class apple extends StatefulWidget {
  @override
  _appleState createState() => _appleState();
}

class _appleState extends State<apple> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Example app: Sign in with Apple'),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Center(
            child: SignInWithAppleButton(
              onPressed: () async {
                final credential = await SignInWithApple.getAppleIDCredential(
                  scopes: [
                    AppleIDAuthorizationScopes.email,
                    AppleIDAuthorizationScopes.fullName,
                  ],
                  webAuthenticationOptions: WebAuthenticationOptions(
                    // TODO: Set the `clientId` and `redirectUri` arguments to the values you entered in the Apple Developer portal during the setup
                    clientId:
                    'com.aboutyou.dart_packages.sign_in_with_apple.example',
                    redirectUri: Uri.parse(
                      'https://flutter-sign-in-with-apple-example.glitch.me/callbacks/sign_in_with_apple',
                    ),
                  ),
                  // TODO: Remove these if you have no need for them
                  nonce: 'example-nonce',
                  state: 'example-state',
                );

                print(credential);

                // This is the endpoint that will convert an authorization code obtained
                // via Sign in with Apple into a session in your system
                final signInWithAppleEndpoint = Uri(
                  scheme: 'https',
                  host: 'flutter-sign-in-with-apple-example.glitch.me',
                  path: '/sign_in_with_apple',
                  queryParameters: <String, String>{
                    'code': credential.authorizationCode,
                    'firstName': credential.givenName,
                    'lastName': credential.familyName,
                    'useBundleId':
                    Platform.isIOS || Platform.isMacOS ? 'true' : 'false',
                    if (credential.state != null) 'state': credential.state,
                  },
                );

                final session = await http.Client().post(
                  signInWithAppleEndpoint,
                );

                // If we got this far, a session based on the Apple ID credential has been created in your system,
                // and you can now set this as the app's session
                print("ssession : $session");
              },
            ),
          ),
        ),
      ),
    );
  }
}*/
