class AuthAccount {
  const AuthAccount({
    required this.id,
    required this.username,
    required this.accessToken,
  });

  final String id;
  final String username;
  final String accessToken;

  factory AuthAccount.fromJson(Map<String, dynamic> json) {
    final accessToken = json['accessToken'] as String?;
    if (accessToken == null || accessToken.isEmpty) {
      throw const FormatException('Missing access token');
    }

    return AuthAccount(
      id: '${json['id'] ?? ''}',
      username: json['username'] as String? ?? '',
      accessToken: accessToken,
    );
  }
}
