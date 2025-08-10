// lib/models/clinic_model.dart

import 'dart:convert';

// Represents a single clinic fetched from the Strapi API.
class Clinic {
  final int id;
  final String title;
  final String address;
  final String schedule;
  final String phones;
  final String? mapLink; // URL for embedding the Google Map, can be null
  final String? titleEn; // New field for English title
  final String? addressEn; // New field for English address
  final String? scheduleEn; // New field for English schedule

  Clinic({
    required this.id,
    required this.title,
    required this.address,
    required this.schedule,
    required this.phones,
    this.mapLink,
    this.titleEn,
    this.addressEn,
    this.scheduleEn,
  });

  // Factory constructor to create a single Clinic object from a JSON map (for one clinic item).
  factory Clinic.fromJson(Map<String, dynamic> json) {
    return Clinic(
      id: json['id'] as int,
      title: json['title'] as String,
      address: json['address'] as String,
      schedule: json['schedule'] as String,
      phones: json['phones'] as String,
      mapLink: json['map'] as String?, // 'map' field can be null
      titleEn: json['title_en'] as String?, // Parse English title
      addressEn: json['address_en'] as String?, // Parse English address
      scheduleEn: json['schedule_en'] as String?, // Parse English schedule
    );
  }

  // Method to convert a Clinic object to a JSON map (useful for sending data).
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'address': address,
      'schedule': schedule,
      'phones': phones,
      'map': mapLink,
      'title_en': titleEn,
      'address_en': addressEn,
      'schedule_en': scheduleEn,
    };
  }
}

// Helper function to parse a list of clinics from the full Strapi JSON response.
// This function expects the full API response structure: { "data": { "Clinic": [...] } }
List<Clinic> parseClinics(String responseBody) {
  final parsed = jsonDecode(responseBody);

  // Navigate to the 'data' object and then to the 'Clinic' array
  final List<dynamic> clinicDataList = parsed['data']['Clinic'];

  return clinicDataList.map<Clinic>((json) => Clinic.fromJson(json)).toList();
}
