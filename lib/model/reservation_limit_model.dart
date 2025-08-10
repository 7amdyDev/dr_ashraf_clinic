class ReservationLimit {
  final int id;
  final String documentId;
  final int smouhaLimit;
  final int agamyLimit;

  ReservationLimit({
    required this.id,
    required this.documentId,
    required this.smouhaLimit,
    required this.agamyLimit,
  });

  // Factory constructor to create a ReservationLimit object from JSON
  factory ReservationLimit.fromJson(Map<String, dynamic> json) {
    // We expect the main data to be nested under a "data" key
    final Map<String, dynamic> data = json['data'];

    return ReservationLimit(
      id: data['id'] as int,
      documentId: data['documentId'] as String,
      smouhaLimit: data['smouha_limit'] as int,
      agamyLimit: data['agamy_limit'] as int,
    );
  }

  // Method to convert a ReservationLimit object to JSON (optional, but good practice)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'documentId': documentId,
      'smouha_limit': smouhaLimit,
      'agamy_limit': agamyLimit,
    };
  }
}
