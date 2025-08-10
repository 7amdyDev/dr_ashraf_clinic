class SocialButton {
  final int id;
  final String link;
  final String iconUrl;

  SocialButton({required this.id, required this.link, required this.iconUrl});

  factory SocialButton.fromJson(Map<String, dynamic> json, String baseUrl) {
    final icon = json['icon'];
    String url = '';
    if (icon != null && icon['url'] != null) {
      url = baseUrl + icon['url'];
    }
    return SocialButton(id: json['id'], link: json['link'], iconUrl: url);
  }
}
