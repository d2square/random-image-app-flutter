import 'package:either_dart/either.dart';
import 'package:random_image_app/core/error/failures.dart';
import 'package:random_image_app/screens/image_screen/domain/entity/image_entity.dart';
abstract class ImageRepository {
  Future<Either<Failure, ImageEntity>> getRandomImage();
}