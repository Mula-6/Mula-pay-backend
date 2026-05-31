import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static final String backendApiLink = dotenv.get("BACKEND_API_LINK");
  static final String cloudinaryName = dotenv.get("CLOUDINARY_NAME");
  static final String cloudinaryUploadPreset = dotenv.get("CLOUDINARY_UPLOAD_PRESET");
}