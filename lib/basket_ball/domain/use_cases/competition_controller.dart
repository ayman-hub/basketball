import 'package:get/get.dart';
enum CompetitionIntial{
  none,
 showScorers,
 showTables,
 showMatches,
 showNews
}
class CompetitionContoller extends GetxController{
  final competitionIntial = CompetitionIntial.none.obs;

  changeCompetition(CompetitionIntial competition){
    print("here ${competitionIntial.toString()}");
    competitionIntial(competition);
    update();
  }
}