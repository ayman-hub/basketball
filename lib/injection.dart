

import 'package:get_it/get_it.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'basket_ball/data/data_sources/shared_preferences.dart';
import 'basket_ball/data/remote_data/dio_remote_data.dart';
import 'basket_ball/data/repositories/data_repositry.dart';
import 'basket_ball/domain/repositories/domain_repositry.dart';
import 'basket_ball/domain/use_cases/case.dart';
final sl = GetIt.instance;

Future<void> init()async{
  //! feature
  // for bloc
  // * cases
  sl.registerLazySingleton(
          () => Cases(domainRepositry: sl())); //? need domain repositry



  // * repository
  sl.registerLazySingleton<DomainRepositry>(
          () => DataRepositry(remoteData: sl(),getSharedPreference: sl()/*, dbHelper: sl()*/));

  //! external
  sl.registerLazySingleton(() => RemoteData());
  sl.registerLazySingleton(() => GetSharedPreference(sharedPreferences: sl()));
  // * database from local data source
  //sl.registerLazySingleton(() => DBHelper());
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}
