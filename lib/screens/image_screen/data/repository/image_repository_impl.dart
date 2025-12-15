import 'package:either_dart/either.dart';
import 'package:random_image_app/core/error/failures.dart';
import 'package:random_image_app/screens/image_screen/data/data_source/image_remote_data_source.dart';
import 'package:random_image_app/screens/image_screen/domain/entity/image_entity.dart';
import '../../domain/repositories/image_repository.dart';

class ImageRepositoryImpl implements ImageRepository {
  final ImageRemoteDataSource remoteDataSource;

  ImageRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, ImageEntity>> getRandomImage() async {
    try {
      final imageModel = await remoteDataSource.getRandomImage();
      return Right(imageModel);
    } catch (e) {
      return Left(ServerFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }
}