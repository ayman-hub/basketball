import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:hi_market/basket_ball/data/data_sources/constant_data.dart';
import 'package:hi_market/basket_ball/domain/entities/get_albums_screen_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_child_competition_initial_children_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_child_competition_initial_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_children_competition_listing_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_code_rules_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_competition_news_load_more_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_etihad_achievement_categories_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_etihad_decision_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_etihad_histories_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_form_screen_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_government_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_home_page_albums_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_home_page_matches_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_home_page_news_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_home_page_option_enities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_home_page_table.dart';
import 'package:hi_market/basket_ball/domain/entities/get_home_page_videos_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_judge_matches_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_last_news_initialize_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_last_viewed_more_news_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_list_parent_categories_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_listing_all_referees_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_listing_statitian_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_login_data.dart';
import 'package:hi_market/basket_ball/domain/entities/get_manager_according_to_branches.dart';
import 'package:hi_market/basket_ball/domain/entities/get_manager_according_to_department_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_manager_according_to_year_enities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_manager_head_Entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_referee_conditions_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_search_page_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_single_player_data_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_team_players_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_videos_screen_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/match_details_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/notification_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/referee_reference_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/referee_report_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/response_failure.dart';
import 'package:hi_market/basket_ball/domain/entities/single_team_achievement_data_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/single_team_related_albums_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/single_team_staff_data_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/single_team_videos_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/teams_screen_initation_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/uncompleted_match_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/videos_screen_categories_load_more_entities.dart';
import 'package:hi_market/basket_ball/domain/use_cases/case.dart';
import 'package:hi_market/injection.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class RemoteData {
  Response response;
  Dio dio = new Dio();

  /*
  * // todo there is a problem with the server
  Future<dynamic> postPhoneDataForCode({String phone}) async {
    try {
      print(GetKeyCodeModel(mobile: phone).toMap());
      FormData formData =
          new FormData.fromMap(GetKeyCodeModel(mobile: phone).toMap());
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.post("https://dawaainc.net/SFA/api/index.php",
          data: formData); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data['type']}");
      print(type[dataType.Success]);
      if (response?.data['type'] == 'success') {
        return CodeModel.fromJson(response.data);
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      print(error.toString());
      return null;
    }
  }*/

  Future<dynamic> albumsScreenInitiation() async {
    try {
      /*print(GetKeyCodeModel(mobile: phone).toMap());
      FormData formData =
      new FormData.fromMap(GetKeyCodeModel(mobile: phone).toMap());*/
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.get(
          "https://egypt.basketball/api/library?action=albums-listing"); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        return GetAlbumScreenEntities.fromJson(response.data);
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> albumsScreenLoadMore(String offset) async {
    try {
      Map<String, String> json = Map();
      json['action'] = "albums-load-more";
      json['offset'] = offset;
      // FormData formData = new FormData.fromMap(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.get(
          "https://egypt.basketball/api/library?action=albums-load-more&offset",
          queryParameters: json); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        return GetAlbumScreenEntities.fromJson(response.data);
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> formScreenInitiation() async {
    try {
      Map<String, String> json = Map();
      json['action'] = "forms-listing";
      // json['offset'] = "offset";
      // FormData formData = new FormData.fromMap(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.get(
          "https://egypt.basketball/api/library?action=forms-listing",
          queryParameters: json); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        return GetFormScreenEntities.fromJson(response.data);
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> videosScreenInitiation() async {
    print("videos list");
    try {
      Map<String, String> json = Map();
      // json['action'] = "videos-listing";
      // json['offset'] = "offset";
      // FormData formData = new FormData.fromMap(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.get(
          "https://egypt.basketball/api/library?action=videos-listing",
          queryParameters: json); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        return GetVideosScreenEntities.fromJson(response.data);
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> singleVideoCategoryScreenInitiation(String id) async {
    try {
      Map<String, String> json = Map();
      json['action'] = "videos-category";
      json['id'] = id;
      // FormData formData = new FormData.fromMap(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.get("https://egypt.basketball/api/library?",
          queryParameters: json); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        return GetVideosScreenEntities.fromJson(response.data);
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> singleVideoCategoryScreenOnScrollLoadMore(
      String id, String offset) async {
    try {
      Map<String, String> json = Map();
      json['action'] = "videos-category-load-more";
      json['id'] = id;
      json['offset'] = offset;
      // FormData formData = new FormData.fromMap(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.get("https://egypt.basketball/api/library?",
          queryParameters: json); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        return GetVideosScreenEntities.fromJson(response.data);
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> teamsScreenInitiation() async {
    try {
      Map<String, String> json = Map();
      json['action'] = "teams-listing";
      //json['id'] = id;
      //json['offset'] = offset;
      // FormData formData = new FormData.fromMap(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.get("https://egypt.basketball/api/teams?",
          queryParameters: json); //ResultModel.fromJson(response.data);
      print("here");
      // print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        return GetTeamScreenInitiationEntities.fromJson(response.data);
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      if (error is DioError) {
        print(error.toString());
      }
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> singleTeamPlayersData(String teamID) async {
    try {
      Map<String, String> json = Map();
      json['action'] = "team-players";
      json['team-id'] = teamID;
      //json['offset'] = offset;
      // FormData formData = new FormData.fromMap(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.get("https://egypt.basketball/api/teams?",
          queryParameters: json); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        return GetSingleTeamPlayersDataEntities.fromJson(response.data);
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> singleTeamStaffData(String teamID) async {
    try {
      Map<String, String> json = Map();
      json['action'] = "team-staff";
      json['team-id'] = teamID;
      //json['offset'] = offset;
      // FormData formData = new FormData.fromMap(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.get("https://egypt.basketball/api/teams?",
          queryParameters: json); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        return GetSingleTeamStaffDataEntities.fromJson(response.data);
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> singleTeamAchievementsData(String teamID) async {
    try {
      Map<String, String> json = Map();
      json['action'] = "team-achievements";
      json['team-id'] = teamID;
      //json['offset'] = offset;
      // FormData formData = new FormData.fromMap(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.get("https://egypt.basketball/api/teams?",
          queryParameters: json); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        return GetSingleTeamAchievementDataEntities.fromJson(response.data);
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> singleTeamRelatedAlbums(String teamID) async {
    try {
      Map<String, String> json = Map();
      json['action'] = "team-albums";
      json['team-id'] = teamID;
      //json['offset'] = offset;
      // FormData formData = new FormData.fromMap(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.get("https://egypt.basketball/api/teams?",
          queryParameters: json); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        return SingleTeamRelatedAlbumsEntities.fromJson(response.data);
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> singleTeamRelatedAlbumsScrollEvent(
      String teamID, String offset) async {
    try {
      Map<String, String> json = Map();
      json['action'] = "team-albums-more";
      json['team-id'] = teamID;
      json['offset'] = offset;
      // FormData formData = new FormData.fromMap(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.get("https://egypt.basketball/api/teams?",
          queryParameters: json); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        return GetAlbumScreenEntities.fromJson(response.data);
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> singleTeamVideosScreenInitiation(String teamID) async {
    try {
      Map<String, String> json = Map();
      json['action'] = "team-videos";
      json['team-id'] = teamID;
      //  json['offset'] = offset;
      // FormData formData = new FormData.fromMap(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.get("https://egypt.basketball/api/teams?",
          queryParameters: json); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        return GetSingleTeamVideosEntities.fromJson(response.data);
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> singleTeamVideosScreenloadmorevideos(
      String teamID, String offset) async {
    try {
      Map<String, String> json = Map();
      json['action'] = "team-videos-load-more";
      json['team-id'] = teamID;
      json['offset'] = offset;
      // FormData formData = new FormData.fromMap(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.get("https://egypt.basketball/api/teams?",
          queryParameters: json); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        return GetVideosScreenCategoriesLoadMoreEntities.fromJson(
            response.data);
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> getEtihadHistoreies() async {
    try {
      Map<String, String> json = Map();
      json['action'] = "histories-listing";
      // json['team-id'] = teamID;
      // json['offset'] = offset;
      // FormData formData = new FormData.fromMap(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.get("https://egypt.basketball/api/about-etihad?",
          queryParameters: json); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        return GetEtihadHistoriesEntities.fromJson(response.data);
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<dynamic>
      getEtihadAchievementsCategoriesAndAchievementsRelateToThisCategory() async {
    try {
      Map<String, String> json = Map();
      json['action'] = "achievements-listing";
      // json['team-id'] = teamID;
      // json['offset'] = offset;
      // FormData formData = new FormData.fromMap(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.get("https://egypt.basketball/api/about-etihad?",
          queryParameters: json); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        return GetEtihadAchievmentsCategoriesEntities.fromJson(response.data);
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> getManagersHead() async {
    try {
      Map<String, String> json = Map();
      json['action'] = "mangers-head";
      // json['team-id'] = teamID;
      // json['offset'] = offset;
      // FormData formData = new FormData.fromMap(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.get("https://egypt.basketball/api/about-etihad?",
          queryParameters: json); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        return GetManagerHeadEntities.fromJson(response.data);
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> getManagersAccordingToDepartments() async {
    try {
      Map<String, String> json = Map();
      json['action'] = "mangers-departments";
      // json['team-id'] = teamID;
      // json['offset'] = offset;
      // FormData formData = new FormData.fromMap(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.get("https://egypt.basketball/api/about-etihad?",
          queryParameters: json); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        return GetManagerAccordingToDepartmentEntities.fromJson(response.data);
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> getManagerAccordingToYear() async {
    try {
      Map<String, String> json = Map();
      json['action'] = "managers-years";
      // json['team-id'] = teamID;
      // json['offset'] = offset;
      // FormData formData = new FormData.fromMap(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.get("https://egypt.basketball/api/about-etihad?",
          queryParameters: json); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        return GetManagerAccordingtoYearEntities.fromJson(response.data);
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> getManagerAccordingToBranches() async {
    try {
      Map<String, String> json = Map();
      json['action'] = "managers-branches";
      // json['team-id'] = teamID;
      // json['offset'] = offset;
      // FormData formData = new FormData.fromMap(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.get("https://egypt.basketball/api/about-etihad?",
          queryParameters: json); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        return GetManagerAccordingtoBranchesEntities.fromJson(response.data);
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> latestNewsScreenInitalization() async {
    try {
      Map<String, String> json = Map();
      json['action'] = "latest-news-listing";
      // json['team-id'] = teamID;
      // json['offset'] = offset;
      // FormData formData = new FormData.fromMap(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.get("https://egypt.basketball/api/news?",
          queryParameters: json); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        return GetLastNewsScreenInitializeEntities.fromJson(response.data);
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> latestNewsLoadMore(String offset) async {
    try {
      Map<String, String> json = Map();
      json['action'] = "news-load-more";
      // json['team-id'] = teamID;
      json['offset'] = offset;
      // FormData formData = new FormData.fromMap(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.get("https://egypt.basketball/api/news?",
          queryParameters: json); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        return GetLastNewsScreenInitializeEntities.fromJson(response.data);
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      if (error is DioError) {
        print(error.response);
      }
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> mostViewedNewsScreenInitialization() async {
    try {
      Map<String, String> json = Map();
      json['action'] = "most-viewed";
      // json['team-id'] = teamID;
      //json['offset'] = offset;
      // FormData formData = new FormData.fromMap(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.get("https://egypt.basketball/api/news?",
          queryParameters: json); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        return GetLoadMostViewedMoreNewsEntities.fromJson(response.data);
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> loadMoreMostViewedNews(String offset) async {
    try {
      Map<String, String> json = Map();
      json['action'] = "most-viewed-load-more";
      // json['team-id'] = teamID;
      json['offset'] = offset;
      // FormData formData = new FormData.fromMap(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.get("https://egypt.basketball/api/news?",
          queryParameters: json); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        return GetLoadMostViewedMoreNewsEntities.fromJson(response.data);
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> suggestedNewsScreenInitalization() async {
    try {
      Map<String, String> json = Map();
      json['action'] = "suggested";
      // json['team-id'] = teamID;
      //json['offset'] = offset;
      // FormData formData = new FormData.fromMap(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.get("https://egypt.basketball/api/news?",
          queryParameters: json); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        return GetLoadMostViewedMoreNewsEntities.fromJson(response.data);
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> loadMoreSuggestedNewsSuccess(String exisitng_posts) async {
    try {
      Map<String, String> json = Map();
      json['action'] = "suggested-load-more";
      json['exisitng_posts'] = exisitng_posts;
      //json['offset'] = offset;
      // FormData formData = new FormData.fromMap(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.get("https://egypt.basketball/api/news?",
          queryParameters: json); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        return GetLoadMostViewedMoreNewsEntities.fromJson(response.data);
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> listingAllRefrees() async {
    try {
      Map<String, String> json = Map();
      json['action'] = "listing-referees";
      //json['exisitng_posts'] = exisitng_posts;
      //json['offset'] = offset;
      // FormData formData = new FormData.fromMap(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.get("https://egypt.basketball/api/game-elements?",
          queryParameters: json); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        return GetListingAllRefereesEntities.fromJson(response.data);
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> refreesCondition() async {
    try {
      Map<String, String> json = Map();
      json['action'] = "referees-conditions";
      //json['exisitng_posts'] = exisitng_posts;
      //json['offset'] = offset;
      // FormData formData = new FormData.fromMap(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.get("https://egypt.basketball/api/game-elements?",
          queryParameters: json); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        return GetRefereesConditionsEntities.fromJson(response.data);
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> listingStaisticians() async {
    try {
      Map<String, String> json = Map();
      json['action'] = "listing-stats";
      //json['exisitng_posts'] = exisitng_posts;
      //json['offset'] = offset;
      // FormData formData = new FormData.fromMap(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.get("https://egypt.basketball/api/game-elements?",
          queryParameters: json); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        return GetListingStatistianEntities.fromJson(response.data);
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> listingCoaches() async {
    try {
      Map<String, String> json = Map();
      json['action'] = "listing-coaches";
      //json['exisitng_posts'] = exisitng_posts;
      //json['offset'] = offset;
      // FormData formData = new FormData.fromMap(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.get("https://egypt.basketball/api/game-elements?",
          queryParameters: json); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        return GetListingAllRefereesEntities.fromJson(response.data);
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> coachesTermsConditions() async {
    try {
      Map<String, String> json = Map();
      json['action'] = "coaches-conditions";
      //json['exisitng_posts'] = exisitng_posts;
      //json['offset'] = offset;
      // FormData formData = new FormData.fromMap(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.get("https://egypt.basketball/api/game-elements?",
          queryParameters: json); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        return GetRefereesConditionsEntities.fromJson(response.data);
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> coachesRules() async {
    try {
      Map<String, String> json = Map();
      json['action'] = "coaches-rules";
      //json['exisitng_posts'] = exisitng_posts;
      //json['offset'] = offset;
      // FormData formData = new FormData.fromMap(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.get("https://egypt.basketball/api/game-elements?",
          queryParameters: json); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        return GetCoachesRulesEntities.fromJson(response.data);
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> homePageMatches(DateTime date) async {
    try {
      Map<String, String> json = Map();
      json['action'] = "matches";
      json['matches-date'] = /*"05/05/2021";*/
          "${date.day.toString().padLeft(2, "0")}/${date.month.toString().padLeft(2, "0")}/${date.year}";
      print(json);
      //json['offset'] = offset;
      // FormData formData = new FormData.fromMap(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.get(
          "https://egypt.basketball/api/pages/homepage.php?",
          queryParameters: json); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        return GetHomePageMatchesEntities.fromJson(response.data);
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> homePageOptions() async {
    try {
      Map<String, String> json = Map();
      json['action'] = "page_options";
      //json['offset'] = offset;
      // FormData formData = new FormData.fromMap(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.get(
          "https://egypt.basketball/api/pages/homepage.php?",
          queryParameters: json); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        // return GetHomePageOptionsEntities.fromJson(response.data);
        return GetHomePageOptionsEntities.fromJson(response.data);
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> homePageNews() async {
    try {
      Map<String, String> json = Map();
      json['action'] = "news";
      // json['matches-date'] = "${date.day}/${date.month}/${date.year}";
      //json['offset'] = offset;
      // FormData formData = new FormData.fromMap(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.get(
          "https://egypt.basketball/api/pages/homepage.php?",
          queryParameters: json); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        return GetHomePageNewsEntities.fromJson(response.data);
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> homePageVideos() async {
    try {
      Map<String, String> json = Map();
      json['action'] = "videos";
      // json['matches-date'] = "${date.day}/${date.month}/${date.year}";
      //json['offset'] = offset;
      // FormData formData = new FormData.fromMap(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.get(
          "https://egypt.basketball/api/pages/homepage.php?",
          queryParameters: json); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        return GetHomePageVideosEntities.fromJson(response.data);
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> homePageAlbums() async {
    try {
      Map<String, String> json = Map();
      json['action'] = "albums";
      // json['matches-date'] = "${date.day}/${date.month}/${date.year}";
      //json['offset'] = offset;
      // FormData formData = new FormData.fromMap(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.get(
          "https://egypt.basketball/api/pages/homepage.php?",
          queryParameters: json); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        return GetHomePageAlbumsEntities.fromJson(response.data);
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> listParentCategories() async {
    try {
      Map<String, String> json = Map();
      json['action'] = "competition-categories";
      //json['exisitng_posts'] = exisitng_posts;
      //json['offset'] = offset;
      // FormData formData = new FormData.fromMap(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.get("https://egypt.basketball/api/competition?",
          queryParameters: json); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        return GetListParentCategoriesEntities.fromJson(response.data);
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> competitionNewsLoadMore(String c_id, String offset) async {
    try {
      Map<String, String> json = Map();
      json['action'] = "news-load-more";
      json['c_id'] = c_id;
      json['offset'] = offset;
      // FormData formData = new FormData.fromMap(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.get("https://egypt.basketball/api/competition?",
          queryParameters: json); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        return GetCompetitionNewsLoadMoreEntities.fromJson(response.data);
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> childrenCompetitionListing(String parent_c_id) async {
    try {
      Map<String, String> json = Map();
      json['action'] = "competitions-listing";
      json['parent_c_id'] = parent_c_id;
      print(json.toString());
      //json['offset'] = offset;
      // FormData formData = new FormData.fromMap(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.get("https://egypt.basketball/api/competition?",
          queryParameters: json); //ResultModel.fromJson(response.data);
      print(response);
      print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        return GetChildrenCompetitionListingEntities.fromJson(response.data);
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      if (error is DioError) {
        print(error.message);
      }
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> childrenCompetitionInitiation(String c_id) async {
    try {
      Map<String, String> json = Map();
      json['action'] = "single-competition";
      json['c_id'] = c_id;
      //json['offset'] = offset;
      // FormData formData = new FormData.fromMap(json);
      print(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.get("https://egypt.basketball/api/competition?",
          queryParameters: json); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        print("here");
        GetChildCompetitionInitiationEntities.fromJson(response.data)
            .data
            .matches
            .forEach((element) {
          print(element.teams);
        });
        return GetChildCompetitionInitiationEntities.fromJson(response.data);
        // return GetChildCompetitionInitiationChildrenEntities();
        print(response.data['data']);
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> childrenCompetitionInitiationForChildren(String c_id) async {
    try {
      Map<String, String> json = Map();
      json['action'] = "single-competition";
      json['c_id'] = c_id;
      print(json);
      //json['offset'] = offset;
      // FormData formData = new FormData.fromMap(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.get("https://egypt.basketball/api/competition?",
          queryParameters: json); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        print("here");
        // print(response.data['data']);
        print(GetChildCompetitionInitiationEntities.fromJson(response.data)
            .toJson());
        return GetChildCompetitionInitiationEntities.fromJson(response.data);
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      if (error is DioError) {
        print("dioError: ${error.message}");
      }
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> getJudgeMatchesEntities() async {
    try {
      Map<String, String> json = Map();
      json['action'] = "judge-initialization";
      //json['c_id'] = c_id;
      //json['offset'] = offset;
      // FormData formData = new FormData.fromMap(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.get(
          "https://egypt.basketball/api/users/dashboard/judge-dashboard.php?",
          queryParameters: json,
          options: Options(headers: {
            "auth": "egybasket ${sl<Cases>().getLoginData().data.token}"
          })); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        // return GetJudgeMatchesEntities.fromJson(response.data);
        return GetJudgeMatchesEntities.fromJson(response.data);
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      if (error is DioError) {
        if (error.response != null) {
          if (error.response != null) {
            return ResponseModelFailure.fromJson(error.response.data);
          }
        }
      }
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> login({String email, String password}) async {
    try {
      Map<String, String> json = Map();
      json['action'] = "user-login";
      json['email'] = email;
      json['password'] = password;
      json['fcm_token'] = sl<Cases>().getNotificationFirebase();
      print(json);
      FormData formData = new FormData.fromMap(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.post("https://egypt.basketball/api/users/login/",
          data: formData); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        return LoginDataEntities.fromJson(response.data);
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      if (error is DioError) {
        if (error.response != null) {
          print(error.response);
          return ResponseModelFailure.fromJson(error.response.data);
        }
      }
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> forgetPassword(String email) async {
    try {
      Map<String, String> json = Map();
      json['action'] = "forgot-password";
      json['email'] = email;
      print(json);
      FormData formData = new FormData.fromMap(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.post(
          "https://egypt.basketball/api/users/forgot-password/",
          data: formData); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        return true;
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> homePageSearch(String search) async {
    try {
      Map<String, String> json = Map();
      json['action'] = "search";
      json['keyword'] = search;
      // json['password'] = password;
      print(json);
      FormData formData = new FormData.fromMap(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.post(
          "https://egypt.basketball//api/pages/homepage.php",
          data: formData); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        return GetSearchPageEntities.fromJson(response.data);
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> contactUs(
      {String email, String name, String message, String phone}) async {
    try {
      Map<String, String> json = Map();
      json['action'] = "contact-us";
      json['email'] = email;
      json['name'] = name;
      json['message'] = message;
      json['phone'] = phone;
      // json['password'] = password;
      print(json);
      FormData formData = new FormData.fromMap(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.post(
          "https://egypt.basketball/api/pages/contact-us/",
          data: formData); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        return true;
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> judgeRegister({
    String firstName,
    String lastName,
    String email,
    String password,
    String phone,
    String weight,
    String height,
    String loginName,
    String nationalID,
    String governmentID,
    String type,
  }) async {
    try {
      print("type: $type");
      Map<String, String> json = Map();
      json['action'] = "judge-register";
      json['first_name'] = firstName;
      json['last_name'] = lastName;
      json['email'] = email;
      json['password'] = password;
      json['phone'] = phone;
      json['weight']=weight;
      json['height']=height;
      json['username'] = loginName;
      json['national_id'] = nationalID;
      json['nat_id'] = nationalID;
      json['governorate'] = governmentID;
      json['ref_type'] = type; //todo Required (international, local)
      print(json);
      FormData formData = new FormData.fromMap(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.post(
          "https://egypt.basketball/api/users/registeration/judge-registeration.php",
          data: formData); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        return true;
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      if (error is DioError) {
        print(error.message);
        if (error.response != null) {
          if (error.response != null) {
            return ResponseModelFailure.fromJson(error.response.data);
          }
        }
      }
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> userRegister(
      {String firstName,
      String lastName,
      String email,
      String password,
      String phone}) async {
    try {
      Map<String, String> json = Map();
      json['action'] = "user-register";
      json['first_name'] = firstName;
      json['last_name'] = lastName;
      json['email'] = email;
      json['password'] = password;
      json['phone'] = phone;
      json['password_confirmation'] = password;
      print(json);
      FormData formData = new FormData.fromMap(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.post(
          "https://egypt.basketball/api/users/registeration/user-registeration.php",
          data: formData); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        return true;
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      if (error is DioError) {
        print(error.message);
        if (error.response != null) {
          return ResponseModelFailure.fromJson(error.response.data);
        }
      }
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> judgeSeeNotification() async {
    try {
      Map<String, String> json = Map();
      json['action'] = "see-notifications";
      print(json);
      FormData formData = new FormData.fromMap(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.post(
          "https://egypt.basketball/api/users/dashboard/judge-dashboard.php",
          data: formData,
          options: Options(headers: {
            "auth": "egybasket ${sl<Cases>().getLoginData().data.token}"
          })); //ResultModel.fromJson(response.data);
      print("response in dio see notification: ${response.data}");
      if (response?.data['status'] == 'success') {
        return true;
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      if (error is DioError) {
        print(error.response.data);
      }
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> judgeNotificationAction({String not_id, bool res}) async {
    try {
      Map<String, dynamic> json = Map();
      json['action'] = "notification-action";
      json['not_id'] = not_id;
      json['res'] = res ? 1 : 2;
      print(json);
      FormData formData = new FormData.fromMap(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.post(
          "https://egypt.basketball/api/users/dashboard/judge-dashboard.php",
          data: formData,
          options: Options(headers: {
            "auth": "egybasket ${sl<Cases>().getLoginData().data.token}"
          })); //ResultModel.fromJson(response.data);
      print("response in dioooo: ${response.data}");
      print("response: ${response?.data['status'] == 'success'}");
      if (response?.data['status'] == 'success') {
        print("response after: ${response.data}");
        return true;
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      print("error Data: $error");
      if (error is DioError) {
        print("error: ${error.error}");
        if (error.response != null) {
          print("error : ${error.response.data}");
          return ResponseModelFailure.fromJson(error.response.data);
        }
      }
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> homePageTable() async {
    try {
      Map<String, dynamic> json = Map();
      json['action'] = "homepage-table";
      print(json);
      FormData formData = new FormData.fromMap(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.post(
          "https://egypt.basketball//api/pages/homepage.php?action=homepage-table",
          data: formData); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        return GetHomePageTableEntities.fromJson(response.data);
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> getEtihadDecision() async {
    try {
      Map<String, dynamic> json = Map();
      json['action'] = "decisions-listing";
      print(json);
      FormData formData = new FormData.fromMap(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.get(
          "https://egypt.basketball/api/about-etihad?action=decisions-listing",
          queryParameters: json); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        return GetEtihadDecisionEntities.fromJson(response.data);
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> socialMediaLogin(
      String name, String email, RoleType role) async {
    try {
      Map<String, dynamic> json = Map();
      json['action'] = "social-media-check";
      json['email'] = email;
      json['role'] = role == RoleType.Judge ? "Judge" : "Guest";
      json['full_name'] = name;
      print(json);
      FormData formData = new FormData.fromMap(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.post("https://egypt.basketball/api/users/login/",
          data: formData); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        return LoginDataEntities.fromJson(response.data);
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> updateUserProfile(String phone, String nationalID,
      String bankName, String accountNo, String iban, String swiftCode) async {
    try {
      Map<String, dynamic> json = Map();
      json['action'] = "update-profile-data";
      json['userID'] = sl<Cases>().getLoginData().data.userID;
      json['phone'] = phone;
      json['bank_name'] = bankName;
      json['account_no'] = accountNo;
      json['iban'] = iban;
      json['swift_code'] = swiftCode;
      print(json);
      FormData formData = new FormData.fromMap(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.post("https://egypt.basketball/api/users/dashboard/",
          data: formData,
          options: Options(headers: {
            "auth": "egybasket ${sl<Cases>().getLoginData().data.token}"
          })); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        return true;
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      if (error is DioError) {
        if (error.response != null) {
          print(error.response.data);
          return ResponseModelFailure.fromJson(response.data);
        }
      }
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> updateUserPicture(File image) async {
    try {
      Map<String, dynamic> json = Map();
      json['action'] = "update-profile-pic";
      json['profile_picture'] = await MultipartFile.fromFile(image.path);
      print(json);
      FormData formData = new FormData.fromMap(json);
      print(formData.fields);
      dio.options.connectTimeout = 60000; //5s
      dio.options.receiveTimeout = 60000;
      response = await dio.post("https://egypt.basketball/api/users/dashboard/",
          data: formData,
          options: Options(headers: {
            "auth": "egybasket ${sl<Cases>().getLoginData().data.token}"
          })); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data}");
      print("here");
      if (response?.data['status'] == 'success') {
        return true;
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      if (error is DioError) {
        print(error.message);
        if (error.response != null) {
          return ResponseModelFailure.fromJson(error.response.data);
        }
      }
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> updateUserPassword(String password) async {
    try {
      Map<String, dynamic> json = Map();
      json['action'] = "update-user-password";
      json['userID'] = sl<Cases>().getLoginData().data.userID;
      json['password'] = password;
      print(json);
      FormData formData = new FormData.fromMap(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.post("https://egypt.basketball/api/users/dashboard/",
          data: formData,
          options: Options(headers: {
            "auth": "egybasket ${sl<Cases>().getLoginData().data.token}"
          })); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        return true;
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      if (error is DioError) {
        if (error.response != null) {
          return ResponseModelFailure.fromJson(error.response.data);
        }
      }
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> startMatch(String matchID) async {
    try {
      Map<String, dynamic> json = Map();
      json['action'] = "start-match";
      json['match_id'] = matchID;
      print(json);
      FormData formData = new FormData.fromMap(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.post(
          "https://egypt.basketball/api/users/dashboard/single-match/",
          data: formData,
          options: Options(headers: {
            "auth": "egybasket ${sl<Cases>().getLoginData().data.token}"
          })); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        return true;
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      if (error is DioError) {
        if (error.response != null) {
          return ResponseModelFailure.fromJson(error.response.data);
        }
      }
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> endMatch(String matchID) async {
    try {
      Map<String, dynamic> json = Map();
      json['action'] = "end-match";
      json['match_id'] = matchID;
      print(json);
      FormData formData = new FormData.fromMap(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.post(
          "https://egypt.basketball/api/users/dashboard/single-match/",
          data: formData,
          options: Options(headers: {
            "auth": "egybasket ${sl<Cases>().getLoginData().data.token}"
          })); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        return true;
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      if (error is DioError) {
        if (error.response != null) {
          return ResponseModelFailure.fromJson(error.response.data);
        }
      }
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> matchResultEntry(String matchID, String team1ID,
      String team2ID, String team1Points, String team2Points,
      {List<ReportPlayerEntities> reportPlayers/*= const[]*/
      }) async {
    try {
      Map<String, dynamic> json = Map();
      json['action'] = "match-results";
      json['match_id'] = matchID;
      json['team1_id'] = team1ID;
      json['team2_id'] = team2ID;
      json['team1_total'] = team1Points;
      json['team2_total'] = team2Points;
      json['results'] =
          reportPlayers.map((e) => "'${e.id}' => '${e.report}'").toList();
      FormData formData = new FormData.fromMap(json);
      print(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.post(
          "https://egypt.basketball/api/users/dashboard/single-match/",
          data: formData,
          options: Options(headers: {
            "auth": "egybasket ${sl<Cases>().getLoginData().data.token}"
          })); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        return true;
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      if (error is DioError) {
        if (error.response != null) {
          return ResponseModelFailure.fromJson(error.response.data);
        }
      }
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> matchNoteEntry(String matchID, String notes) async {
    try {
      Map<String, dynamic> json = Map();
      json['action'] = "match-notes";
      json['match_id'] = matchID;
      json['notes'] = notes;
      print(json);
      FormData formData = new FormData.fromMap(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.post(
          "https://egypt.basketball/api/users/dashboard/single-match/",
          data: formData,
          options: Options(headers: {
            "auth": "egybasket ${sl<Cases>().getLoginData().data.token}"
          })); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        return true;
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      if (error is DioError) {
        if (error.response != null) {
          return ResponseModelFailure.fromJson(error.response.data);
        }
      }
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> matchReportEntry(
      String matchID, String report, File image) async {
    try {
      Map<String, dynamic> json = Map();
      json['action'] = "match-report";
      json['match_id'] = matchID;
      json['report'] = report;
      json['report_image'] = await MultipartFile.fromFile(image.path);
      print(json);
      FormData formData = new FormData.fromMap(json);
      dio.options.connectTimeout = 12000000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.post(
          "https://egypt.basketball/api/users/dashboard/single-match/",
          data: formData,
          options: Options(headers: {
            "auth": "egybasket ${sl<Cases>().getLoginData().data.token}",
          }),onSendProgress: (x,y){
            print("${(x/y) * 100}");
      }); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        return true;
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      if (error is DioError) {
        if (error.response != null) {
          return ResponseModelFailure.fromJson(error.response.data);
        }
      }
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> refereeReport() async {
    try {
      Map<String, dynamic> json = Map();
      json['action'] = "referee-report";
      print(json);
      FormData formData = new FormData.fromMap(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.get(
          "https://egypt.basketball/api/users/dashboard/judge-dashboard.php?",
          queryParameters: json,
          options: Options(headers: {
            "auth": "egybasket ${sl<Cases>().getLoginData().data.token}"
          })); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        return RefereeReportEntities.fromJson(response.data);
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      if (error is DioError) {
        if (error.response != null) {
          if (error.response != null) {
            return ResponseModelFailure.fromJson(error.response.data);
          }
        }
      }
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> refereeReference() async {
    try {
      Map<String, dynamic> json = Map();
      json['action'] = "referee-reference";
      print(json);
      FormData formData = new FormData.fromMap(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.get(
          "https://egypt.basketball/api/users/dashboard/judge-dashboard.php?",
          queryParameters: json,
          options: Options(headers: {
           // "auth": "egybasket ${sl<Cases>().getLoginData().data.token}"
          })); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        return RefereeReferenceEntities.fromJson(response.data);
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      if (error is DioError) {
        if (error.response != null) {
          return ResponseModelFailure.fromJson(error.response.data);
        }
      }
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> getMatchEntities(String matchID) async {
    try {
      Map<String, dynamic> json = Map();
      json['action'] = "match-details";
      json['match_id'] = matchID;
      print(json);
      FormData formData = new FormData.fromMap(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.get(
          "https://egypt.basketball/api/users/dashboard/single-match?",
          queryParameters: json,
          options: Options(headers: {
            "auth": "egybasket ${sl<Cases>().getLoginData().data.token}"
          })); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        return GetMatchDetailsEntities.fromJson(response.data);
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      if (error is DioError) {
        print(error.response);
        if (error.response != null) {
          return ResponseModelFailure.fromJson(error.response.data);
        }
      }
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> unCompletedMatchEntities() async {
    try {
      Map<String, dynamic> json = Map();
      json['action'] = "get-uncompleted-match";
      print(json);
      FormData formData = new FormData.fromMap(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.post(
          "https://egypt.basketball/api/users/dashboard/judge-dashboard.php",
          data: formData,
          options: Options(headers: {
            "auth": "egybasket ${sl<Cases>().getLoginData().data.token}"
          })); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        return UnCompletedMatchEntities.fromJson(response.data);
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      if (error is DioError) {
        if (error.response != null) {
          return ResponseModelFailure.fromJson(error.response.data);
        }
      }
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> getNotification() async {
    try {
      Map<String, dynamic> json = Map();
      json['action'] = "get-notifications";
      print(json);
      FormData formData = new FormData.fromMap(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.get(
          "https://egypt.basketball/api/users/dashboard/judge-dashboard.php",
          queryParameters: json,
          options: Options(headers: {
            "auth": "egybasket ${sl<Cases>().getLoginData().data.token}"
          })); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        return NotificationEntities.fromJson(response.data);
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      if (error is DioError) {
        if (error.response != null) {
          return ResponseModelFailure.fromJson(error.response.data);
        }
      }
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> getGovernmentEntities() async {
    try {
      Map<String, dynamic> json = Map();
      json['action'] = "get-governorates";
      print(json);
      FormData formData = new FormData.fromMap(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.get(
        "https://egypt.basketball/api/users/registeration/judge-registeration.php?",
        queryParameters:
            json, /*options: Options(headers: {"auth":"egybasket ${sl<Cases>().getLoginData().data.token}"})*/
      ); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        return GovernmentEntities.fromJson(response.data);
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      if (error is DioError) {
        print(error.response);
      }
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> pushNotification(
      LoginDataEntities login, bool cancelNotification) async {
    try {
      print("push Notification");
      Map<String, dynamic> json = Map();
      print("1");
      json['user_id'] = login.data.userID.toString();
      print("2");
      print(sl<Cases>().getNotificationFirebase());
      print(
          "getNotificationFirebase: ${sl<Cases>().getNotificationFirebase().toString()}");
      json['fcm_token'] = cancelNotification == true
          ? ""
          : sl<Cases>().getNotificationFirebase();
      print("3");
      print(" json of notification : $json");
      //json['offset'] = offset;
      FormData formData = new FormData.fromMap(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.post(
          "https://egypt.basketball/api/users/fcm-token.php?action=update-fcmtoken",
          data: formData); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        return true;
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> cancelMatch(String matchID, String note) async {
    try {
      print("cancel match");
      Map<String, dynamic> json = Map();
      print("1");
      json['action'] = "match-cancel";
      json['match_id'] = matchID;
      json['notes'] = note;
/*      print("2");
      print(sl<Cases>().getNotificationFirebase());
      print("getNotificationFirebase: ${sl<Cases>().getNotificationFirebase().toString()}");
      json['fcm_token'] = sl<Cases>().getNotificationFirebase();*/
      print("3");
      print(" json of cancel match : $json");
      //json['offset'] = offset;
      FormData formData = new FormData.fromMap(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.post(
          "https://egypt.basketball/api/users/dashboard/single-match/",
          data: formData,
          options: Options(headers: {
            "auth": "egybasket ${sl<Cases>().getLoginData().data.token}"
          })); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        return true;
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> getPlayersTeams(String matchID) async {
    try {
      /*     print("cancel match");
      Map<String, dynamic> json = Map();
      print("1");
      json['action'] = "match-cancel";
      json['match_id'] = matchID;
      json['notes'] = note;
*/ /*      print("2");
      print(sl<Cases>().getNotificationFirebase());
      print("getNotificationFirebase: ${sl<Cases>().getNotificationFirebase().toString()}");
      json['fcm_token'] = sl<Cases>().getNotificationFirebase();*/ /*
      print("3");
      print(" json of cancel match : $json");*/
      //json['offset'] = offset;
      //FormData formData = new FormData.fromMap(json);
      dio.options.connectTimeout = 10000; //5s
      dio.options.receiveTimeout = 10000;
      response = await dio.get(
          "https://egypt.basketball/api/users/dashboard/single-match?action=match-players&match_id=$matchID" /*,data: formData*/,
          options: Options(headers: {
            "auth": "egybasket ${sl<Cases>().getLoginData().data.token}"
          })); //ResultModel.fromJson(response.data);
      print("response in dio: ${response.data}");
      if (response?.data['status'] == 'success') {
        return GetTeamPlayersEntities.fromJson(response.data);
      } else {
        print('responseModel ${ResponseModelFailure.fromJson(response.data)}');
        return ResponseModelFailure.fromJson(response.data);
      }
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
