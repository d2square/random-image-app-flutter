import 'package:dio/dio.dart';
import 'package:random_image_app/core/constants/api_constants.dart';
import 'package:random_image_app/screens/image_screen/data/model/image_model.dart';
abstract class ImageRemoteDataSource {
  Future<ImageModel> getRandomImage();
}

class ImageRemoteDataSourceImpl implements ImageRemoteDataSource {
  final Dio dio;

  ImageRemoteDataSourceImpl({required this.dio});

  @override
  Future<ImageModel> getRandomImage() async {
    try {
      final response = await dio.get(
        '${ApiConstants.baseUrl}${ApiConstants.imageEndpoint}',
      );

      if (response.statusCode == 200) {
        return ImageModel.fromJson(response.data);
      } else {
        throw Exception('Failed to fetch image');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Connection timeout');
      } else if (e.type == DioExceptionType.badResponse) {
        throw Exception('Server error: ${e.response?.statusCode}');
      } else {
        throw Exception('Network error');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
