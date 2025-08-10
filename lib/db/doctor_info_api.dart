import 'package:dr_ashraf_clinic/model/clinic_contact.dart';
import 'package:dr_ashraf_clinic/model/doctor_model.dart';
import 'package:dr_ashraf_clinic/model/reservation_limit_model.dart';
import 'package:dr_ashraf_clinic/model/social_button_model.dart';
import 'package:dr_ashraf_clinic/model/video_model.dart';
import 'package:get/get.dart';

class DoctorInfoApi extends GetConnect {
  static const String _apiBaseUrl = 'https://blog.ashrafyehia.al-iyada.com';

  @override
  void onInit() {
    httpClient.baseUrl = _apiBaseUrl;

    // Add a request modifier to set the content type
    httpClient.defaultContentType = 'application/json; charset=UTF-8';
  }

  // A method to fetch the doctor's profile data
  Future<Doctor> getDoctorProfile() async {
    // Use the specific populate parameter to ensure the image is included
    const url = '/api/landing-page?populate=doctor_profile.doctor_image';
    final response = await get(url);

    // Check if the response was successful and has data
    if (response.body != null && response.statusCode == 200) {
      // Navigate the nested JSON structure to get the doctor profile data
      final dynamic doctorData = response.body['data']['doctor_profile'][0];

      if (doctorData != null) {
        // Pass the base URL to the fromJson factory to build the full image URL
        return Doctor.fromJson(doctorData, _apiBaseUrl);
      } else {
        throw Exception('Doctor data not found in response');
      }
    } else {
      throw Exception('Failed to fetch doctor profile');
    }
  }

  Future<List<SocialButton>> getSocialButtons() async {
    const url = '/api/social-media?populate=social_buttons.icon';
    final response = await get(url);
    if (response.body != null && response.statusCode == 200) {
      final List<dynamic> buttonsData = response.body['data']['social_buttons'];

      return buttonsData
          .map((json) => SocialButton.fromJson(json, _apiBaseUrl))
          .toList();
    } else {
      throw Exception('Failed to load social buttons');
    }
  }

  Future<List<Clinic>> fetchClinics() async {
    final url = '/api/contact?populate=*'; // Example endpoint, adjust as needed

    final response = await get(url);
    if (response.body != null && response.statusCode == 200) {
      final List<dynamic> clinicData = response.body['data']['Clinic'];

      return clinicData.map((json) => Clinic.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load social buttons');
    }
  }

  Future<List<Video>> fetchVideos() async {
    final url = '/api/videos?populate=*'; // Adjust endpoint as needed

    final response = await get(url);

    if (response.statusCode == 200 && response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      final List<dynamic> videos = response.body['data'];
      return videos.map<Video>((json) => Video.fromJson(json)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      throw Exception('Failed to load videos: ${response.statusCode}');
    }
  }

  Future<ReservationLimit> fetchReservation() async {
    final url = '/api/reservation?populate=*'; // Adjust endpoint as needed

    final response = await get(url);

    if (response.statusCode == 200 && response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      final Map<String, dynamic> responseBody = response.body;

      // Ensure 'data' exists and is a Map before parsing
      if (responseBody.containsKey('data') && responseBody['data'] != null) {
        return ReservationLimit.fromJson(responseBody);
      } else {
        throw Exception('Invalid response format');
      }
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      throw Exception('Failed to load videos: ${response.statusCode}');
    }
  }
}
