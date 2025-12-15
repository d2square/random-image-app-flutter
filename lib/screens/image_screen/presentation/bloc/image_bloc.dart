import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_image_app/core/use_cases/use_case.dart';
import 'package:random_image_app/screens/image_screen/domain/use_case/get_random_image.dart';
import 'image_event.dart';
import 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  final GetRandomImage getRandomImage;

  ImageBloc({required this.getRandomImage}) : super(ImageInitial()) {
    on<FetchRandomImageEvent>(_onFetchRandomImage);
  }

  Future<void> _onFetchRandomImage(
    FetchRandomImageEvent event,
    Emitter<ImageState> emit,
  ) async {
    emit(ImageLoading());

    final result = await getRandomImage(NoParams());

    result.fold(
      (failure) => emit(ImageError(message: failure.message)),
      (image) => emit(ImageLoaded(image: image)),
    );
  }
}
