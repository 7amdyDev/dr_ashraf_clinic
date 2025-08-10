class Doctor {
  final int id;
  final String doctorNameEn;
  final String specialtyEn;
  final String qualificationEn;
  final String doctorNameAr;
  final String specialtyAr;
  final String qualificationAr;
  final String? imageUrl; // This field will hold the full image URL

  Doctor({
    required this.id,
    required this.doctorNameEn,
    required this.specialtyEn,
    required this.qualificationEn,
    required this.doctorNameAr,
    required this.specialtyAr,
    required this.qualificationAr,
    this.imageUrl,
  });

  factory Doctor.fromJson(Map<String, dynamic> json, String baseUrl) {
    // Safely parse the nested image URL
    final imageJson = json['doctor_image'];
    final String? relativeUrl = imageJson?['url'];
    final String? fullImageUrl = relativeUrl != null
        ? '$baseUrl$relativeUrl'
        : null;

    return Doctor(
      id: json['id'],
      doctorNameEn: json['doctor_name_en'],
      specialtyEn: json['specialty_en'],
      qualificationEn: json['qualification_en'],
      doctorNameAr: json['doctor_name_ar'],
      specialtyAr: json['specialty_ar'],
      qualificationAr: json['qualification_ar'],
      imageUrl: fullImageUrl,
    );
  }
}
