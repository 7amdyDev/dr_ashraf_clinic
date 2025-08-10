class Video {
  final int id;
  final String title;
  final String videoLink;
  final double width;
  final double height;
  final DateTime createdAt; // Add this field

  Video({
    required this.id,
    required this.title,
    required this.videoLink,
    required this.createdAt, // Require it in the constructor
    this.width = 0.0,
    this.height = 0.0,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    String rawLink = json['link'] as String;
    String extractedVideoLink;
    double extractedWidth = 0.0;
    double extractedHeight = 0.0;

    if (rawLink.startsWith('<iframe src="') &&
        rawLink.contains('"></iframe>')) {
      final srcStartIndex = rawLink.indexOf('src="') + 5;
      final srcEndIndex = rawLink.indexOf('"', srcStartIndex);
      extractedVideoLink = rawLink.substring(srcStartIndex, srcEndIndex);

      final widthMatch = RegExp(r'width="(\d+)"').firstMatch(rawLink);
      if (widthMatch != null) {
        extractedWidth = double.tryParse(widthMatch.group(1)!) ?? 0.0;
      }

      final heightMatch = RegExp(r'height="(\d+)"').firstMatch(rawLink);
      if (heightMatch != null) {
        extractedHeight = double.tryParse(heightMatch.group(1)!) ?? 0.0;
      }
    } else {
      extractedVideoLink = rawLink;
    }

    return Video(
      id: json['id'] as int,
      title: json['title'] as String,
      videoLink: extractedVideoLink,
      width: extractedWidth,
      height: extractedHeight,
      // Parse the createdAt field from the JSON
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}
