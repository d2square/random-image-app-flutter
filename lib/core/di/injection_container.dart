import 'package:dio/dio.dart';
import 'package:random_image_app/core/constants/api_constants.dart';
import 'package:random_image_app/screens/image_screen/data/data_source/image_remote_data_source.dart';
import 'package:random_image_app/screens/image_screen/data/repository/image_repository_impl.dart';
import 'package:random_image_app/screens/image_screen/domain/repositories/image_repository.dart';
import 'package:random_image_app/screens/image_screen/domain/use_case/get_random_image.dart';
import 'package:random_image_app/screens/image_screen/presentation/bloc/image_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(
        () => ImageBloc(getRandomImage: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetRandomImage(sl()));

  // Repository
  sl.registerLazySingleton<ImageRepository>(
        () => ImageRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<ImageRemoteDataSource>(
        () => ImageRemoteDataSourceImpl(dio: sl()),
  );

  // External
  sl.registerLazySingleton(() => Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ),
  ));
}