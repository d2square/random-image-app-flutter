

import 'package:random_image_app/screens/image_screen/domain/entity/image_entity.dart';

abstract class ImageState {}

class ImageInitial extends ImageState {}

class ImageLoading extends ImageState {}

class ImageLoaded extends ImageState {
  final ImageEntity image;

  ImageLoaded({required this.image});
}

class ImageError extends ImageState {
  final String message;

  ImageError({required this.message});
}
