import 'package:random_image_app/core/error/failures.dart';
import 'package:random_image_app/core/use_cases/use_case.dart';
import 'package:random_image_app/screens/image_screen/domain/entity/image_entity.dart';
import 'package:either_dart/either.dart';
import '../repositories/image_repository.dart';

class GetRandomImage implements UseCase<ImageEntity, NoParams> {
  final ImageRepository repository;

  GetRandomImage(this.repository);

  @override
  Future<Either<Failure, ImageEntity>> call(NoParams params) async {
    return await repository.getRandomImage();
  }
}