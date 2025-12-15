import 'package:random_image_app/screens/image_screen/domain/entity/image_entity.dart';

class ImageModel extends ImageEntity {
  const ImageModel({required String url}) : super(url: url);

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      url: json['url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
    };
  }
}