

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:hi_market/basket_ball/data/data_sources/constant_data.dart';
import 'package:hi_market/basket_ball/domain/entities/get_login_data.dart';
import 'package:hi_market/basket_ball/domain/entities/get_match_id_entiies.dart';
import 'package:hi_market/basket_ball/domain/entities/get_team_players_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/notification_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/username_password_entities.dart';
import 'package:image_picker/image_picker.dart';

abstract class DomainRepositry {
  Future<dynamic> albumsScreenInitiation();

  Future<dynamic> albumsScreenLoadMore(String offset);

  Future<dynamic> formScreenInitiation();

  Future<dynamic> videosScreenInitiation();

  Future<dynamic> singleVideoCategoryScreenInitiation(String id);

  Future<dynamic> singleVideoCategoryScreenOnScrollLoadMore(
      String id, String offset);

  Future<dynamic> teamsScreenInitiation();

  Future<dynamic> singleTeamPlayersData(String teamID);

  Future<dynamic> singleTeamStaffData(String teamID);

  Future<dynamic> singleTeamAchievementsData(String teamID);

  Future<dynamic> singleTeamRelatedAlbums(String teamID);

  Future<dynamic> singleTeamRelatedAlbumsScrollEvent(
      String teamID, String offset);

  Future<dynamic> singleTeamVideosScreenInitiation(String teamID);

  Future<dynamic> singleTeamVideosScreenloadmorevideos(
      String teamID, String offset);

  Future<dynamic> getEtihadHistoreies();

  Future<dynamic>
      getEtihadAchievementsCategoriesAndAchievementsRelateToThisCategory();

  Future<dynamic> getManagersHead();

  // todo need to put action
  Future<dynamic> getManagersAccordingToDepartments();

  Future<dynamic> latestNewsScreenInitalization();

  Future<dynamic> latestNewsLoadMore(String offset);

  Future<dynamic> mostViewedNewsScreenInitialization();

  Future<dynamic> suggestedNewsScreenInitalization();

  Future<dynamic> loadMoreSuggestedNewsSuccess(String exisitng_posts);

  Future<dynamic> listingAllRefrees();

  Future<dynamic> refreesCondition();

  Future<dynamic> listingStaisticians();

  Future<dynamic> listingCoaches();

  Future<dynamic> coachesTermsConditions();

  Future<dynamic> coachesRules();

  Future<dynamic> getManagerAccordingToYear();

  Future<dynamic> getManagerAccordingToBranches();

  Future<dynamic> getManagerAccordingToYears();

  Future<dynamic> loadMoreMostViewedNews(String offset);

  Future<dynamic> homePageMatches(DateTime date);

  Future<dynamic> homePageOptions();

  Future<dynamic> homePageNews();

  Future<dynamic> homePageVideos();

  Future<dynamic> homePageAlbums();

  Future<dynamic> listParentCategories();

  Future<dynamic> competitionNewsLoadMore(String c_id, String offset);

  Future<dynamic> childrenCompetitionListing(String parent_c_id);

  Future<dynamic> childrenCompetitionInitiation(String c_id);

  Future<dynamic> getJudgeMatchesEntities();

  Future<dynamic> login({String email, String password});

  Future<dynamic> judgeRegister(
      {String firstName,
      String lastName,
      String email,
      String password,
      String phone,String nationalID,String governmentID,String type});

  Future<dynamic> judgeSeeNotification();

  Future<dynamic> judgeNotificationAction({String not_id, bool res});


  Future<dynamic> forgetPassword(String email);
  Future<dynamic> homePageSearch(String search);
  Future<dynamic> contactUs({String email ,String name ,String message ,String phone});
  Future<dynamic> userRegister({String firstName,String lastName,String email,String password,String phone});
  Future<dynamic> homePageTable() ;
  Future<dynamic> getEtihadDecision();

  Future<void> setLoginData(LoginDataEntities loginDataEntities);

  LoginDataEntities getLoginData();

  Future<dynamic> socialMediaLogin(String name ,String email,RoleType role);
  Future<dynamic> updateUserProfile(String phone,String nationalID,String bankName,String accountNo,String iban,String swiftCode);

  Future<dynamic> updateUserPicture(File image) ;
  Future<dynamic> updateUserPassword(String password) ;

  Future<dynamic> childrenCompetitionInitiationForChildren(String c_id);

  Future<void> setUserPassword(
      UserNameAndPasswordEntities userNameAndPasswordEntities);

  UserNameAndPasswordEntities getUserPassword();

  Future<dynamic> startMatch(String matchID);
  Future<dynamic> endMatch(String matchID);

  Future<dynamic> matchResultEntry(String matchID,String team1ID,String team2ID,String team1Points,String team2Points,List<ReportPlayerEntities> reportPlayers) ;
  Future<dynamic> matchNoteEntry(String matchID,String notes);
  Future<dynamic> matchReportEntry(String matchID,String report,File image);
  Future<dynamic> refereeReport();

  Future<dynamic> unCompletedMatchEntities();

  Future<dynamic> getMatchEntities(String matchID);

  Future<dynamic> refereeReference();

  Future<dynamic> getGovernmentEntities();

  Future<dynamic> getNotification();

  Future<void> setMatchIdSharedPreference(
      GetMatchIdEntities getMatchIdEntities);

  GetMatchIdEntities getMatchIdSharedPreference();


  Future<void> setMatchReportIDSharedPreference(
      GetMatchIdEntities getMatchIdEntities);

  GetMatchIdEntities getMatchReportIDSharedPreference();

  Future<void> setNotificationIdSharedPreference(
      List getNotificationIdEntities);

  List getNotificationIdSharedPreference();

  Future<void> setNotificationFirebase(
      String notificationFirebase);

  String getNotificationFirebase();

  Future<dynamic> pushNotification(LoginDataEntities login,bool cancelNotification);

  Future<void> putNotification(
      bool notificationPut);

  bool getPutNotificaton();

  Future<dynamic> cancelMatch(String matchID, String note);

  Future<dynamic> getPlayersTeams(String matchID);
}
