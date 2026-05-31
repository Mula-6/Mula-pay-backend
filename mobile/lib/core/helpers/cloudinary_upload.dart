import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:mobile/core/helpers/logger.dart';
import '../constant/constant.dart';

class CloudinaryUpload {
  static CloudinaryPublic _init() {
    CloudinaryPublic cloudinaryPublic = CloudinaryPublic(
      AppConfig.cloudinaryName,
      AppConfig.cloudinaryUploadPreset,
    );
    return cloudinaryPublic;
  }

  static Future<String?> uploadImage(String path) async {
    try {
      CloudinaryResponse response = await CloudinaryUpload._init().uploadFile(
        CloudinaryFile.fromFile(
          path,
          resourceType: CloudinaryResourceType.Image,
        ),
      );
      return response.secureUrl;
    } on CloudinaryException catch (e) {
      logger.e(e);
      return null;
    }
  }
}
