import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:hi_market/basket_ball/data/data_sources/constant_data.dart';
import 'package:hi_market/basket_ball/domain/entities/get_login_data.dart';
import 'package:hi_market/basket_ball/domain/entities/get_match_id_entiies.dart';
import 'package:hi_market/basket_ball/domain/entities/get_team_players_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/notification_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/username_password_entities.dart';
import 'package:hi_market/basket_ball/domain/repositories/domain_repositry.dart';
import 'package:image_picker/image_picker.dart';

class Cases {
  DomainRepositry domainRepositry;

  Cases({@required this.domainRepositry});

  Future<dynamic> albumsScreenInitiation() {
    return domainRepositry.albumsScreenInitiation();
  }

  Future<dynamic> albumsScreenLoadMore(String offset) {
    return domainRepositry.albumsScreenLoadMore(offset);
  }

  Future<dynamic> formScreenInitiation() {
    return domainRepositry.formScreenInitiation();
  }

  Future<dynamic> videosScreenInitiation() {
    return domainRepositry.videosScreenInitiation();
  }

  Future<dynamic> singleVideoCategoryScreenInitiation(String id) {
    return domainRepositry.singleVideoCategoryScreenInitiation(id);
  }

  Future<dynamic> singleVideoCategoryScreenOnScrollLoadMore(
      String id, String offset) {
    return domainRepositry.singleVideoCategoryScreenOnScrollLoadMore(
        id, offset);
  }

  Future<dynamic> teamsScreenInitiation() {
    return domainRepositry.teamsScreenInitiation();
  }

  Future<dynamic> singleTeamPlayersData(String teamID) {
    return domainRepositry.singleTeamPlayersData(teamID);
  }

  Future<dynamic> singleTeamStaffData(String teamID) {
    return domainRepositry.singleTeamStaffData(teamID);
  }

  Future<dynamic> singleTeamAchievementsData(String teamID) {
    return domainRepositry.singleTeamAchievementsData(teamID);
  }

  Future<dynamic> singleTeamRelatedAlbums(String teamID) {
    return domainRepositry.singleTeamRelatedAlbums(teamID);
  }

  Future<dynamic> singleTeamRelatedAlbumsScrollEvent(
      String teamID, String offset) {
    return domainRepositry.singleTeamRelatedAlbumsScrollEvent(teamID, offset);
  }

  Future<dynamic> singleTeamVideosScreenInitiation(String teamID) {
    return domainRepositry.singleTeamVideosScreenInitiation(teamID);
  }

  Future<dynamic> singleTeamVideosScreenloadmorevideos(
      String teamID, String offset) {
    return domainRepositry.singleTeamVideosScreenloadmorevideos(teamID, offset);
  }

  Future<dynamic> getEtihadHistoreies() {
    return domainRepositry.getEtihadHistoreies();
  }

  Future<dynamic>
      getEtihadAchievementsCategoriesAndAchievementsRelateToThisCategory() {
    return domainRepositry
        .getEtihadAchievementsCategoriesAndAchievementsRelateToThisCategory();
  }

  Future<dynamic> getManagersHead() {
    return domainRepositry.getManagersHead();
  }

  // todo need to put action
  Future<dynamic> getManagersAccordingToDepartments() {
    return domainRepositry.getManagersAccordingToDepartments();
  }

  Future<dynamic> latestNewsScreenInitalization() {
    return domainRepositry.latestNewsScreenInitalization();
  }

  Future<dynamic> latestNewsLoadMore(String offset) {
    return domainRepositry.latestNewsLoadMore(offset);
  }

  Future<dynamic> mostViewedNewsScreenInitialization() {
    return domainRepositry.mostViewedNewsScreenInitialization();
  }

  Future<dynamic> suggestedNewsScreenInitalization() {
    return domainRepositry.suggestedNewsScreenInitalization();
  }

  Future<dynamic> loadMoreSuggestedNewsSuccess(String exisitng_posts) {
    return domainRepositry.loadMoreSuggestedNewsSuccess(exisitng_posts);
  }

  Future<dynamic> listingAllRefrees() {
    return domainRepositry.listingAllRefrees();
  }

  Future<dynamic> refreesCondition() {
    return domainRepositry.refreesCondition();
  }

  Future<dynamic> listingStaisticians() {
    return domainRepositry.listingStaisticians();
  }

  Future<dynamic> listingCoaches() {
    return domainRepositry.listingCoaches();
  }

  Future<dynamic> coachesTermsConditions() {
    return domainRepositry.coachesTermsConditions();
  }

  Future<dynamic> coachesRules() {
    return domainRepositry.coachesRules();
  }

  Future<dynamic> getManagerAccordingToYear() {
    return domainRepositry.getManagerAccordingToYear();
  }

  Future<dynamic> getManagerAccordingToBranches() {
    return domainRepositry.getManagerAccordingToBranches();
  }

  Future<dynamic> getManagerAccordingToYears() {
    return domainRepositry.getManagerAccordingToYear();
  }

  Future<dynamic> loadMoreMostViewedNews(String offset) {
    return domainRepositry.loadMoreMostViewedNews(offset);
  }

  Future<dynamic> homePageMatches(DateTime date) {
    return domainRepositry.homePageMatches(date);
  }

  Future<dynamic> homePageOptions() {
    return domainRepositry.homePageOptions();
  }

  Future<dynamic> homePageNews() {
    return domainRepositry.homePageNews();
  }

  Future<dynamic> homePageVideos() {
    return domainRepositry.homePageVideos();
  }

  Future<dynamic> homePageAlbums() {
    return domainRepositry.homePageAlbums();
  }

  Future<dynamic> listParentCategories() {
    return domainRepositry.listParentCategories();
  }

  Future<dynamic> competitionNewsLoadMore(String c_id, String offset) {
    return domainRepositry.competitionNewsLoadMore(c_id, offset);
  }

  Future<dynamic> childrenCompetitionListing(String parent_c_id) {
    return domainRepositry.childrenCompetitionListing(parent_c_id);
  }

  Future<dynamic> childrenCompetitionInitiation(String c_id) {
    return domainRepositry.childrenCompetitionInitiation(c_id);
  }

  Future<dynamic> getJudgeMatchesEntities() {
    return domainRepositry.getJudgeMatchesEntities();
  }

  Future<dynamic> login({String email, String password}) {
    return domainRepositry.login(email: email, password: password);
  }

  Future<dynamic> judgeRegister(
      {String firstName,
      String lastName,
      String email,
      String password,
      String phone,
      String type,
        String weight,
        String height,
       String loginName,
        String nationalID,
        String governmentID
      }) {
    return domainRepositry.judgeRegister(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        phone: phone,
        weight:weight,
        height:height,
      loginName: loginName,
      nationalID:nationalID,
      governmentID: governmentID,
      type: type
    );
  }

  Future<dynamic> judgeSeeNotification() {
    return domainRepositry.judgeSeeNotification();
  }

  Future<dynamic> judgeNotificationAction({String not_id, bool res}) {
    return domainRepositry.judgeNotificationAction(not_id: not_id, res: res);
  }

  Future<dynamic> forgetPassword(String email) {
    return domainRepositry.forgetPassword(email);
  }

  Future<dynamic> homePageSearch(String search) {
    return domainRepositry.homePageSearch(search);
  }

  Future<dynamic> contactUs(
      {String email, String name, String message, String phone}) {
    return domainRepositry.contactUs(
        email: email, name: name, message: message, phone: phone);
  }

  Future<dynamic> userRegister(
      {String firstName,
      String lastName,
      String email,
      String password,
      String phone}) {
    return domainRepositry.userRegister(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        phone: phone);
  }

  Future<dynamic> homePageTable() {
    return domainRepositry.homePageTable();
  }

  Future<dynamic> getEtihadDecision() {
    return domainRepositry.getEtihadDecision();
  }

  Future<void> setLoginData(LoginDataEntities loginDataEntities) {
    return domainRepositry.setLoginData(loginDataEntities);
  }

  LoginDataEntities getLoginData() {
    return domainRepositry.getLoginData();
  }

  Future<dynamic> socialMediaLogin(String name, String email, RoleType role) {
    return domainRepositry.socialMediaLogin(name, email, role);
  }

  Future<dynamic> updateUserProfile(String phone,String nationalID,String bankName,String accountNo,String iban,String swiftCode){
    return domainRepositry.updateUserProfile(phone, nationalID, bankName, accountNo, iban, swiftCode);
  }

  Future<dynamic> updateUserPicture(File image) {
    return domainRepositry.updateUserPicture(image);
  }

  Future<dynamic> updateUserPassword(String password) {
    return domainRepositry.updateUserPassword(password);
  }

  Future<dynamic> childrenCompetitionInitiationForChildren(String c_id) {
    return domainRepositry.childrenCompetitionInitiationForChildren(c_id);
  }

  Future<void> setUserPassword(
      UserNameAndPasswordEntities userNameAndPasswordEntities) {
    return domainRepositry.setUserPassword(userNameAndPasswordEntities);
  }

  UserNameAndPasswordEntities getUserPassword() {
    return domainRepositry.getUserPassword();
  }

  Future<dynamic> startMatch(String matchID){
    return domainRepositry.startMatch(matchID);
  }
  Future<dynamic> endMatch(String matchID){
    return domainRepositry.endMatch(matchID);
  }
  Future<dynamic> matchResultEntry(String matchID,String team1ID,String team2ID,String team1Points,String team2Points,List<ReportPlayerEntities> reportPlayers){
    return domainRepositry.matchResultEntry(matchID, team1ID, team2ID, team1Points, team2Points,reportPlayers);
  }
  Future<dynamic> matchNoteEntry(String matchID,String notes){
    return domainRepositry.matchNoteEntry(matchID, notes);
  }
  Future<dynamic> matchReportEntry(String matchID,String report,File image){
    return domainRepositry.matchReportEntry(matchID, report,image);
  }
  Future<dynamic> refereeReport(){
    return domainRepositry.refereeReport();
  }
  Future<dynamic> unCompletedMatchEntities(){
    return domainRepositry.unCompletedMatchEntities();
  }
  Future<dynamic> getMatchEntities(String matchID){
    return domainRepositry.getMatchEntities(matchID);
  }
  Future<dynamic> refereeReference(){
    return domainRepositry.refereeReference();
  }
  Future<dynamic> getGovernmentEntities(){
    return domainRepositry.getGovernmentEntities();
  }
  Future<dynamic> getNotification(){
    return domainRepositry.getNotification();
  }

  Future<void> setMatchIdSharedPreference(
      GetMatchIdEntities getMatchIdEntities){
    return domainRepositry.setMatchIdSharedPreference(getMatchIdEntities);
  }

  GetMatchIdEntities getMatchIdSharedPreference(){
    return domainRepositry.getMatchIdSharedPreference();
  }
  Future<void> setMatchReportIDSharedPreference(
      GetMatchIdEntities getMatchIdEntities){
    return domainRepositry.setMatchReportIDSharedPreference(getMatchIdEntities);
  }

  GetMatchIdEntities getMatchReportIDSharedPreference(){
    return domainRepositry.getMatchReportIDSharedPreference();
  }
  Future<void> setNotificationIdSharedPreference(
      List getNotificationIdEntities){
    return domainRepositry.setNotificationIdSharedPreference(getNotificationIdEntities);
  }

  List getNotificationIdSharedPreference(){
    if(domainRepositry.getNotificationIdSharedPreference() == null){
      return List();
    }else{
      return domainRepositry.getNotificationIdSharedPreference();
    }
  }
  Future<void> setNotificationFirebase(
      String notificationFirebase){
    return domainRepositry.setNotificationFirebase(notificationFirebase);
  }

  String getNotificationFirebase(){
    return domainRepositry.getNotificationFirebase();
  }
  Future<dynamic> pushNotification(LoginDataEntities login,bool cancelNotification){
    return domainRepositry.pushNotification(login,cancelNotification);
  }
  Future<void> putNotification(
      bool notificationPut){
    return domainRepositry.putNotification(notificationPut);
  }

  bool getPutNotificaton(){
    return domainRepositry.getPutNotificaton();
  }

  Future<dynamic> cancelMatch(String matchID, String note){
    return domainRepositry.cancelMatch(matchID, note);
  }

  Future<dynamic> getPlayersTeams(String matchID){
    return domainRepositry.getPlayersTeams(matchID);
  }
}

