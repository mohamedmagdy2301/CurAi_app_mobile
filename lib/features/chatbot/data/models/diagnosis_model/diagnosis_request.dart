import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class DiagnosisRequest {
  DiagnosisRequest({
    this.inputText,
    this.image,
  });

  final String? inputText;
  final XFile? image;
  MultipartFile? photoFile;
  String photoName = '';

  /// Converts the request to a JSON-compatible map.
  Future<Map<String, dynamic>> toJson() async {
    final data = <String, dynamic>{
      'input_text': inputText,
    };

    /// Convert image to MultipartFile if present
    if (image != null) {
      photoName = image!.path.split('/').last;
      photoFile = await MultipartFile.fromFile(
        image!.path,
        filename: photoName,
      );
      data['image'] = photoFile;
    }

    return data;
  }
}
