
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:hi_market/basket_ball/data/data_sources/constant_data.dart';
import 'package:hi_market/basket_ball/data/data_sources/shared_preferences.dart';
import 'package:hi_market/basket_ball/data/remote_data/dio_remote_data.dart';
import 'package:hi_market/basket_ball/domain/entities/get_login_data.dart';
import 'package:hi_market/basket_ball/domain/entities/get_match_id_entiies.dart';
import 'package:hi_market/basket_ball/domain/entities/get_team_players_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/notification_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/username_password_entities.dart';
import 'package:hi_market/basket_ball/domain/repositories/domain_repositry.dart';
import 'package:image_picker/image_picker.dart';

class DataRepositry extends DomainRepositry {
  RemoteData remoteData;
  GetSharedPreference getSharedPreference;

  // DBHelper dbHelper;

  DataRepositry({
    @required this.remoteData,
    @required this.getSharedPreference,
    /*@required this.dbHelper*/
  });

  @override
  Future albumsScreenInitiation() {
    return remoteData.albumsScreenInitiation();
  }

  @override
  Future albumsScreenLoadMore(String offset) {
    return remoteData.albumsScreenLoadMore(offset);
  }

  @override
  Future coachesRules() {
    return remoteData.coachesRules();
  }

  @override
  Future coachesTermsConditions() {
    return remoteData.coachesTermsConditions();
  }

  @override
  Future formScreenInitiation() {
    return remoteData.formScreenInitiation();
  }

  @override
  Future getEtihadAchievementsCategoriesAndAchievementsRelateToThisCategory() {
    return remoteData
        .getEtihadAchievementsCategoriesAndAchievementsRelateToThisCategory();
  }

  @override
  Future getEtihadHistoreies() {
    return remoteData.getEtihadHistoreies();
  }

  @override
  Future getManagersAccordingToDepartments() {
    return remoteData.getManagersAccordingToDepartments();
  }

  @override
  Future getManagersHead() {
    return remoteData.getManagersHead();
  }

  @override
  Future latestNewsLoadMore(String offset) {
    return remoteData.latestNewsLoadMore(offset);
  }

  @override
  Future latestNewsScreenInitalization() {
    return remoteData.latestNewsScreenInitalization();
  }

  @override
  Future listingAllRefrees() {
    return remoteData.listingAllRefrees();
  }

  @override
  Future listingCoaches() {
    return remoteData.listingCoaches();
  }

  @override
  Future listingStaisticians() {
    return remoteData.listingStaisticians();
  }

  @override
  Future loadMoreSuggestedNewsSuccess(String exisitng_posts) {
    return remoteData.loadMoreSuggestedNewsSuccess(exisitng_posts);
  }

  @override
  Future mostViewedNewsScreenInitialization() {
    return remoteData.mostViewedNewsScreenInitialization();
  }

  @override
  Future refreesCondition() {
    return remoteData.refreesCondition();
  }

  @override
  Future singleTeamAchievementsData(String teamID) {
    return remoteData.singleTeamAchievementsData(teamID);
  }

  @override
  Future singleTeamPlayersData(String teamID) {
    return remoteData.singleTeamPlayersData(teamID);
  }

  @override
  Future singleTeamRelatedAlbums(String teamID) {
    return remoteData.singleTeamRelatedAlbums(teamID);
  }

  @override
  Future singleTeamRelatedAlbumsScrollEvent(String teamID, String offset) {
    return remoteData.singleTeamRelatedAlbumsScrollEvent(teamID, offset);
  }

  @override
  Future singleTeamStaffData(String teamID) {
    return remoteData.singleTeamStaffData(teamID);
  }

  @override
  Future singleTeamVideosScreenInitiation(String teamID) {
    return remoteData.singleTeamVideosScreenInitiation(teamID);
  }

  @override
  Future singleTeamVideosScreenloadmorevideos(String teamID, String offset) {
    return remoteData.singleTeamVideosScreenloadmorevideos(teamID, offset);
  }

  @override
  Future singleVideoCategoryScreenInitiation(String id) {
    return remoteData.singleVideoCategoryScreenInitiation(id);
  }

  @override
  Future singleVideoCategoryScreenOnScrollLoadMore(String id, String offset) {
    return remoteData.singleVideoCategoryScreenOnScrollLoadMore(id, offset);
  }

  @override
  Future suggestedNewsScreenInitalization() {
    return remoteData.suggestedNewsScreenInitalization();
  }

  @override
  Future teamsScreenInitiation() {
    return remoteData.teamsScreenInitiation();
  }

  @override
  Future videosScreenInitiation() {
    return remoteData.videosScreenInitiation();
  }

  @override
  Future getManagerAccordingToYear() {
    return remoteData.getManagerAccordingToYear();
  }

  @override
  Future getManagerAccordingToBranches() {
   return remoteData.getManagerAccordingToBranches();
  }

  @override
  Future getManagerAccordingToYears() {
    return remoteData.getManagerAccordingToYear();
  }

  @override
  Future loadMoreMostViewedNews(String offset) {
    return remoteData.loadMoreMostViewedNews(offset);
  }

  @override
  Future childrenCompetitionInitiation(String c_id) {
    return remoteData.childrenCompetitionInitiation(c_id);
  }

  @override
  Future childrenCompetitionListing(String parent_c_id) {
    return remoteData.childrenCompetitionListing(parent_c_id);
  }

  @override
  Future competitionNewsLoadMore(String c_id, String offset) {
    return remoteData.competitionNewsLoadMore(c_id, offset);
  }

  @override
  Future homePageAlbums() {
    return remoteData.homePageAlbums();
  }

  @override
  Future homePageMatches(DateTime date) {
    return remoteData.homePageMatches(date);
  }

  @override
  Future homePageNews() {
    return remoteData.homePageNews();
  }

  @override
  Future homePageOptions() {
    return remoteData.homePageOptions();
  }

  @override
  Future homePageVideos() {
    return remoteData.homePageVideos();
  }

  @override
  Future listParentCategories() {
    return remoteData.listParentCategories();
  }

  @override
  Future getJudgeMatchesEntities() {
   return remoteData.getJudgeMatchesEntities();
  }

  @override
  Future judgeNotificationAction({String not_id, bool res}) {
    return remoteData.judgeNotificationAction(not_id: not_id,res: res);
  }

  @override
  Future judgeRegister({String firstName, String lastName, String email, String password, String phone,String type,String nationalID,String governmentID}) {
   return remoteData.judgeRegister(firstName: firstName,lastName: lastName,email: email,phone: phone,password: password,nationalID:nationalID,type: type,governmentID: governmentID);
  }

  @override
  Future judgeSeeNotification() {
    return remoteData.judgeSeeNotification();
  }

  @override
  Future login({String email, String password}) {
   return remoteData.login(email: email,password: password);
  }

  @override
  Future contactUs({String email, String name, String message, String phone}) {
    return remoteData.contactUs(email: email,name: name,message: message,phone: phone);
  }

  @override
  Future forgetPassword(String email) {
    return remoteData.forgetPassword(email);
  }

  @override
  Future homePageSearch(String search) {
   return remoteData.homePageSearch(search);
  }

  @override
  Future homePageTable() {
    return remoteData.homePageTable();
  }

  @override
  Future userRegister({String firstName, String lastName, String email, String password, String phone,String type}) {
    return remoteData.userRegister(firstName: firstName,lastName: lastName,email: email,password: password,phone: phone);
  }

  @override
  Future getEtihadDecision() {
    return remoteData.getEtihadDecision();
  }

  @override
  LoginDataEntities getLoginData() {
    return getSharedPreference.getLoginData();
  }

  @override
  Future<void> setLoginData(LoginDataEntities loginDataEntities) {
    return getSharedPreference.setLoginData(loginDataEntities);
  }

  @override
  Future socialMediaLogin(String name, String email, RoleType role) {
    return remoteData.socialMediaLogin(name, email, role);
  }



  @override
  Future updateUserPassword(String password) {
    return remoteData.updateUserPassword(password);
  }

  @override
  Future updateUserPicture(File image) {
    return remoteData.updateUserPicture(image);
  }

  @override
  Future childrenCompetitionInitiationForChildren(String c_id) {
   return remoteData.childrenCompetitionInitiationForChildren(c_id);
  }

  @override
  UserNameAndPasswordEntities getUserPassword() {
    return getSharedPreference.getUserPassword();
  }

  @override
  Future<void> setUserPassword(UserNameAndPasswordEntities userNameAndPasswordEntities) {
    return getSharedPreference.setUserPassword(userNameAndPasswordEntities);
  }

  @override
  Future endMatch(String matchID) {
    return remoteData.endMatch(matchID);
  }

  @override
  Future startMatch(String matchID) {
    return remoteData.startMatch(matchID);
  }

  @override
  Future matchNoteEntry(String matchID, String notes) {
    return remoteData.matchNoteEntry(matchID, notes);
  }

  @override
  Future matchReportEntry(String matchID, String report,File image) {
    return remoteData.matchReportEntry(matchID, report,image);
  }

  @override
  Future matchResultEntry(String matchID, String team1ID, String team2ID, String team1Points, String team2Points,List<ReportPlayerEntities> reportPlayers) {
   return remoteData.matchResultEntry(matchID, team1ID, team2ID, team1Points, team2Points,reportPlayers: reportPlayers);
  }

  @override
  Future refereeReport() {
    return remoteData.refereeReport();
  }

  @override
  Future unCompletedMatchEntities() {
    return remoteData.unCompletedMatchEntities();
  }

  @override
  Future getMatchEntities(String matchID) {
   return remoteData.getMatchEntities(matchID);
  }

  @override
  Future refereeReference() {
    return remoteData.refereeReference();
  }

  @override
  Future getGovernmentEntities() {
    return remoteData.getGovernmentEntities();
  }

  @override
  Future getNotification() {
    return remoteData.getNotification();
  }

  @override
  GetMatchIdEntities getMatchIdSharedPreference() {
   return getSharedPreference.getMatchIdSharedPreference();
  }

  @override
  Future<void> setMatchIdSharedPreference(GetMatchIdEntities getMatchIdEntities) {
    return getSharedPreference.setMatchIdSharedPreference(getMatchIdEntities);
  }

  @override
  GetMatchIdEntities getMatchReportIDSharedPreference() {
    return getSharedPreference.getMatchReportIDSharedPreference();
  }

  @override
  Future<void> setMatchReportIDSharedPreference(GetMatchIdEntities getMatchIdEntities) {
   return getSharedPreference.setMatchReportIDSharedPreference(getMatchIdEntities);
  }

  @override
  List getNotificationIdSharedPreference() {
    return getSharedPreference.getNotificationIdSharedPreference();
  }

  @override
  Future<void> setNotificationIdSharedPreference( getNotificationIdEntities) {
   return getSharedPreference.setNotificationIdSharedPreference(getNotificationIdEntities);
  }

  @override
  String getNotificationFirebase() {
    return getSharedPreference.getNotificationFirebase();
  }

  @override
  Future pushNotification(LoginDataEntities login,bool cancelNotification) {
    return remoteData.pushNotification(login,cancelNotification);
  }

  @override
  Future<void> setNotificationFirebase(String notificationFirebase) {
    return getSharedPreference.setNotificationFirebase(notificationFirebase);
  }

  @override
  bool getPutNotificaton() {
    return getSharedPreference.getPutNotificaton();
  }

  @override
  Future<void> putNotification(bool notificationPut) {
    return getSharedPreference.putNotification(notificationPut);
  }

  @override
  Future updateUserProfile(String phone, String nationalID, String bankName, String accountNo, String iban, String swiftCode) {
    return remoteData.updateUserProfile(phone, nationalID, bankName, accountNo, iban, swiftCode);
  }

  @override
  Future cancelMatch(String matchID, String note) {
    return remoteData.cancelMatch(matchID, note);
  }

  @override
  Future getPlayersTeams(String matchID) {
    return remoteData.getPlayersTeams(matchID);
  }
}
