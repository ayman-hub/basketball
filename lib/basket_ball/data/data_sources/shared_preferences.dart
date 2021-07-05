import 'dart:convert';

import 'package:hi_market/basket_ball/domain/entities/get_login_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:hi_market/basket_ball/domain/entities/get_match_id_entiies.dart';
import 'package:hi_market/basket_ball/domain/entities/notification_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/username_password_entities.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String SHAREDPREFERENCE_LOGIN_DATA = "static";
const String SHAREDPREFERENCE_PASSWORD = "password";
const String SHAREDPREFERENCE_MATCHES = "matches";
const String SHAREDPREFERENCE_MATCHES_END_REPORT = "match_end_report";
const String SHAREDPREFERENCE_NOTIFICATIONS = "notificationsId";
const String SHAREDPREFERENCE_NOTIFICATION_FIREBASE = "notificationsـfirebase";
const String SHAREDPREFERENCE_NOTIFICATION_PUT = "notifications_PUT";

class GetSharedPreference {
  SharedPreferences sharedPreferences;


  GetSharedPreference({@required this.sharedPreferences});
  Future<void> setLoginData(
      LoginDataEntities loginDataEntities) async {
    print("insert data: " + jsonEncode(loginDataEntities.toJson()));
    sharedPreferences.setString(
        SHAREDPREFERENCE_LOGIN_DATA, jsonEncode(loginDataEntities.toJson()));
  }

  LoginDataEntities getLoginData() {
    if(sharedPreferences?.getString(SHAREDPREFERENCE_LOGIN_DATA)!= null){
      print(" get data :" +
          LoginDataEntities.fromJson(
              jsonDecode(sharedPreferences?.getString(SHAREDPREFERENCE_LOGIN_DATA)))
              .toJson()
              .toString());
      return LoginDataEntities?.fromJson(
          jsonDecode(sharedPreferences?.getString(SHAREDPREFERENCE_LOGIN_DATA)));}else{
      return null;
    }
  }

  Future<void> setUserPassword(
      UserNameAndPasswordEntities userNameAndPasswordEntities) async {
    print("insert data: " + jsonEncode(userNameAndPasswordEntities.toJson()));
    sharedPreferences.setString(
        SHAREDPREFERENCE_PASSWORD, jsonEncode(userNameAndPasswordEntities.toJson()));
  }

  UserNameAndPasswordEntities getUserPassword() {
    if(sharedPreferences?.getString(SHAREDPREFERENCE_PASSWORD)!= null){
      print(" get data :" +
          UserNameAndPasswordEntities.fromJson(
              jsonDecode(sharedPreferences?.getString(SHAREDPREFERENCE_PASSWORD)))
              .toJson()
              .toString());
      return UserNameAndPasswordEntities?.fromJson(
        jsonDecode(sharedPreferences?.getString(SHAREDPREFERENCE_PASSWORD)));}else{
      return null;
    }
  }

  Future<void> setMatchIdSharedPreference(
      GetMatchIdEntities getMatchIdEntities) async {
    print("insert data: " + jsonEncode(getMatchIdEntities.toJson()));
    sharedPreferences.setString(
        SHAREDPREFERENCE_MATCHES, jsonEncode(getMatchIdEntities.toJson()));
  }

  GetMatchIdEntities getMatchIdSharedPreference() {
    if(sharedPreferences?.getString(SHAREDPREFERENCE_MATCHES)!= null){
      print(" get data :" +
          GetMatchIdEntities.fromJson(
              jsonDecode(sharedPreferences?.getString(SHAREDPREFERENCE_MATCHES)))
              .toJson()
              .toString());
      return GetMatchIdEntities?.fromJson(
          jsonDecode(sharedPreferences?.getString(SHAREDPREFERENCE_MATCHES)));}else{
      return null;
    }
  }

  Future<void> setMatchReportIDSharedPreference(
      GetMatchIdEntities getMatchIdEntities) async {
    print("insert data: " + jsonEncode(getMatchIdEntities.toJson()));
    sharedPreferences.setString(
        SHAREDPREFERENCE_MATCHES_END_REPORT, jsonEncode(getMatchIdEntities.toJson()));
  }

  GetMatchIdEntities getMatchReportIDSharedPreference() {
    if(sharedPreferences?.getString(SHAREDPREFERENCE_MATCHES_END_REPORT)!= null){
      print(" get data :" +
          GetMatchIdEntities.fromJson(
              jsonDecode(sharedPreferences?.getString(SHAREDPREFERENCE_MATCHES_END_REPORT)))
              .toJson()
              .toString());
      return GetMatchIdEntities?.fromJson(
          jsonDecode(sharedPreferences?.getString(SHAREDPREFERENCE_MATCHES_END_REPORT)));}else{
      return null;
    }
  }

  Future<void> setNotificationIdSharedPreference(
      List getNotificationIdEntities) async {
    print("insert data: " + jsonEncode(getNotificationIdEntities));
    sharedPreferences.setString(
        SHAREDPREFERENCE_NOTIFICATIONS, jsonEncode(getNotificationIdEntities));
  }

  List getNotificationIdSharedPreference() {
    if(sharedPreferences?.getString(SHAREDPREFERENCE_NOTIFICATIONS)!= null){
      print(" get data :" +
              jsonDecode(sharedPreferences?.getString(SHAREDPREFERENCE_NOTIFICATIONS))
              .toString());
      return
          jsonDecode(sharedPreferences?.getString(SHAREDPREFERENCE_NOTIFICATIONS));}else{
      return null;
    }
  }
  Future<void> setNotificationFirebase(
      String notificationFirebase) async {
    print("insert data: " + notificationFirebase);
    sharedPreferences.setString(
        SHAREDPREFERENCE_NOTIFICATION_FIREBASE, notificationFirebase);
  }

  String getNotificationFirebase() {
    if(sharedPreferences?.getString(SHAREDPREFERENCE_NOTIFICATION_FIREBASE)!= null){
      print(" get data :" +
          sharedPreferences.getString(SHAREDPREFERENCE_NOTIFICATION_FIREBASE));
      return sharedPreferences.getString(SHAREDPREFERENCE_NOTIFICATION_FIREBASE);}else{
      return null;
    }
  }

  Future<void> putNotification(
      bool notificationPut) async {
    print("insert data: " + notificationPut.toString());
    sharedPreferences.setBool(
        SHAREDPREFERENCE_NOTIFICATION_PUT, notificationPut);
  }

  bool getPutNotificaton() {
    if(sharedPreferences?.getBool(SHAREDPREFERENCE_NOTIFICATION_PUT)!= null){
      print(" get data :" +
          sharedPreferences.getBool(SHAREDPREFERENCE_NOTIFICATION_PUT).toString());
      return sharedPreferences.getBool(SHAREDPREFERENCE_NOTIFICATION_PUT);}else{
      return null;
    }
  }
}
